function [namelist, cbound, valcube, r1, c1] = EKRGtraceWithSeed(namePre, namePost, tstr, CFPB, YFPB, sizeThres, maxI, invertLog) 
%load M
filenameCFP=[namePre{1} tstr{1} namePost{1}]
M=imread(filenameCFP);
[coords] = autofindpoint(M,maxI,invertLog,sizeThres);
c = coords(:,1);
r = coords(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Set default parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stoppingpoints=547.*ones(length(r),1);
defaultThreshold=4;
minThreshold=1;
thresholdStep=0.100;
minArea=80;
maxArea=700;
minDiameter=8;                                          %for smoothing
dilationSize=7; 
CFPbackground=CFPB;                                                                                %Modify
YFPbackground=YFPB;                                                                                %Modify
CFPbackgroundMC=0.606;
YFPbackgroundMC=0.156;
bgThresh=YFPbackground+20;
plotOn=0;
pstr='Data';
% construct matrix of points to analyze at each time
nmatrix=zeros(length(tstr),length(coords));
cbound=cell(length(tstr),length(coords));
nindex(length(tstr),length(coords)).PixelList=[];
valcube=zeros(length(tstr), length(coords), 15);

%%%%%%%%%%%%%%%%%%%%%%%%
%   Main body of code
%%%%%%%%%%%%%%%%%%%%%%%%


for t=1:length(tstr)
    
    currentTstr=tstr{t};
    currentTstr;
    ti=str2num(currentTstr(2:end))

	filenameCFP=[namePre{1} tstr{t} namePost{1}];
    filenameYFP=[namePre{2} tstr{t} namePost{2}];
    filenameRFP=[namePre{3} tstr{t} namePost{3}];
    namelist(t)=cellstr(filenameCFP);
    
    %Find the farthest points from pointpicker % Add ifs to keep within
    %image bounds.  
    imageTest=imread(filenameCFP);
    [rmax cmax]=size(imageTest);

    
    c1 = min(c)-30;
    if c1 < 0
        c1=0;
    end
    c2 = max(c)+30;
    if c2 > cmax
        c2 = cmax;
    end
    r1 = min(r)-30;
    if r1 < 0
        r1 = 0;
    end
    r2 = max(r)+30;
    if r2 > rmax
        r2 = rmax;
    end
    
    %Load images with constrained boundaries
    currentCFP=imread(filenameCFP, 'PixelRegion', {[r1,r2],[c1,c2]});        
    currentYFP=imread(filenameYFP, 'PixelRegion', {[r1,r2],[c1,c2]});        
    currentRFP=imread(filenameRFP, 'PixelRegion', {[r1,r2],[c1,c2]});
    
    currentRatio=double(currentCFP-CFPbackground)./double(currentYFP-YFPbackground);
    currentCFPmc=double(currentCFP)./mean(mean(currentCFP));
    currentYFPmc=double(currentYFP)./mean(mean(currentYFP));
    currentRatioMC=double(currentCFPmc-CFPbackgroundMC)./double(currentYFPmc-YFPbackgroundMC);
    aboveThreshold=double(currentYFP>bgThresh);%%ERROR?
    currentRatio=currentRatio.*aboveThreshold;
    currentRatioMC=currentRatioMC.*aboveThreshold;
    
    %Find edges for cfp and yfp images
    hy = fspecial('sobel');
    hx = hy';
    
    cIy = imfilter(double(currentCFP), hy, 'replicate');
    cIx = imfilter(double(currentCFP), hx, 'replicate');
    cedge = sqrt(cIx.^2 + cIy.^2);
    
    
    SizeOfSmoothingFilter=2.35*minDiameter/3.5;
    sigma = SizeOfSmoothingFilter/2.35;
    h = fspecial('gaussian', [round(SizeOfSmoothingFilter) round(SizeOfSmoothingFilter)], sigma);

    cedgesmooth = imfilter(cedge, h, 'replicate');
    
    logedgesmooth=log10(cedgesmooth);
    
    
    for n=1:length(coords)
        currentThreshold=defaultThreshold;
        tooBig=1;
        cellDetectable=1;
        %loop until the appropriate region is found, or no region can be
        %found
        while tooBig && cellDetectable
            currentThreshold=currentThreshold-thresholdStep;
            bw=logedgesmooth>currentThreshold;
            bwi=~bw;
            [bwb bwl]=bwboundaries(bwi);
            if t==1%handles the case for the first frame in which this point is being tracked
                regionNum=bwl(floor(r(n)), floor(c(n)));
                regionArea=sum(sum(bwl==regionNum)); % adding the number of pixels within the current region to find area
                if regionNum==0;
                    regionArea=1;
                end
                sizeChange=1;
            elseif nindex(t-1,n).PixelList(:,1)==0;%handles the case where cell has been lost
                cellDetectable=0;
                regionNum=0;
                regionArea=0;
                sizeChange=1;
            else
                px=nindex(t-1,n).PixelList(:,1)-c1; %get x pixels from previous frame KNOWN ISSUE: should correct for possible shift in r1,r2,c1,c2 between frames
                size(px);
                py=nindex(t-1,n).PixelList(:,2)-r1; %get y pixels from previous frame
                size(bwl);
                lind=sub2ind(size(bwl),py,px);  %convert pixels from xy to indices
                regionNum=mode(bwl(lind));
                if regionNum==0
                    overlapregion=bwl(lind);
                    overlapnz=find(overlapregion); 
                         if ~isempty(overlapnz)
                            regionNum=mode(overlapregion(overlapnz));  %find the region inthe current bwl that overlaps most with the region identified for this point in the previous time point
                         end
                end

                
                regionArea=sum(sum(bwl==regionNum));%find the size of the current region by adding the number of pixels in it
                oldSize=length(px); %size of the old region
                sizeChange=regionArea/oldSize;
            end
            
            tooBig=regionArea>maxArea||sizeChange>1.5; %deals with errors caused  by dropping threshold too low
            if currentThreshold<minThreshold;
                cellDetectable=0;
            end
            
            
        end
        
        thresholds(t,n)=currentThreshold;
        
        if regionNum>0 && regionArea>0
            % obtain and store list of pixels for identified region
            pln=regionprops(bwl, 'PixelList');
            %before storing, we add back r1 and c1 to the coordinates so
            %that they are correct with respect to the full original image
            pln(regionNum).PixelList(:,1)=pln(regionNum).PixelList(:,1)+c1;
            pln(regionNum).PixelList(:,2)=pln(regionNum).PixelList(:,2)+r1;
            nindex(t,n)=pln(regionNum);
            
            % dilate nuclear region to cover part of the cytosol and store
            % the larger region
            regOnly=bwl==regionNum;
            se=strel('disk',7);
            regDilated=imdilate(regOnly,se);
            plc=regionprops(regDilated,'PixelList');
            cb=bwboundaries(regDilated);
            cbound(t,n)=cb(1);
            
            % calculate and store mean fret ratio for whole cyto/nuc region
            cx=plc.PixelList(:,1);
            cy=plc.PixelList(:,2);
            clind=sub2ind(size(bwl),cy,cx);

            valcube(t,n,1)= mean(currentRatio(clind));
            valcube(t,n,2)= mean(currentRatioMC(clind));
            valcube(t,n,3)= mean(currentCFP(clind));
            valcube(t,n,4)= mean(currentYFP(clind));
            valcube(t,n,5)= mean(currentRFP(clind));
            
            % calculate and store mean fret ratio for nuclear region
            nx=pln(regionNum).PixelList(:,1);
            ny=pln(regionNum).PixelList(:,2);
            nlind=sub2ind(size(bwl),ny,nx);

            valcube(t,n,6)= mean(currentRatio(nlind));
            valcube(t,n,7)= mean(currentRatioMC(nlind));
            valcube(t,n,8)= mean(currentCFP(nlind));
            valcube(t,n,9)= mean(currentYFP(nlind));
            valcube(t,n,10)= mean(currentRFP(nlind));
            
            % calculate and store mean fret ratio for just the cytosolic donut region
            [CNintersect, in, ic]=intersect(nlind,clind);
            clind(ic)=[];

            valcube(t,n,11)= mean(currentRatio(nlind));
            valcube(t,n,12)= mean(currentRatioMC(nlind));
            valcube(t,n,13)= mean(currentCFP(nlind));
            valcube(t,n,14)= mean(currentYFP(nlind));
            valcube(t,n,15)= mean(currentRFP(nlind));
            
            c(n)=floor(mean(cx));
            r(n)=floor(mean(cy));
            
        else
            nindex(t,n).PixelList=[0 0];
        end

        
    end
    
end

save(['data_xy' filenameCFP '.mat']);
