function [namelist, cbound, rvalw, r1, c1] = EKRGtraceMod(ppoints, preT, posT, tstr, CFPB, YFPB) 
fid = fopen(ppoints,'r');
[a, c, r, startingpoints, e, f] = textread(ppoints, '%s %d %d %d %s %s', 'headerlines', 1);

stoppingpoints=547.*ones(length(r),1);
defaultThreshold=5;
minThreshold=2;
thresholdStep=0.1;
minArea=100;
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
nmatrix=zeros(length(tstr),length(startingpoints));
cbound=cell(length(tstr),length(startingpoints));
nindex(length(tstr),length(startingpoints)).PixelList=[];




for t=1%:length(tstr)
    
    currentTstr=tstr{t};
    currentTstr
    ti=str2num(currentTstr(2:end))
    preT
    posT

	filenameCFP=[preT{1} tstr{t} posT{1}]
    filenameYFP=[preT{2} tstr{t} posT{2}]
    filenameRFP=[preT{3} tstr{t} posT{3}]
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
    
    yIy = imfilter(double(currentYFP), hy, 'replicate');
    yIx = imfilter(double(currentYFP), hx, 'replicate');
    yedge = sqrt(yIx.^2 + yIy.^2);
    
    
    SizeOfSmoothingFilter=2.35*minDiameter/3.5;
    sigma = SizeOfSmoothingFilter/2.35;
    h = fspecial('gaussian', [round(SizeOfSmoothingFilter) round(SizeOfSmoothingFilter)], sigma);
    
    yedgesmooth = imfilter(yedge, h, 'replicate');
    cedgesmooth = imfilter(cedge, h, 'replicate');
    
    logedgesmooth=log10(cedgesmooth.*yedgesmooth);
    
    nucpoints= find((ti>=startingpoints).*(ti<=stoppingpoints));
    
    
    for n=nucpoints'
        currentThreshold=defaultThreshold;
        tooBig=1;
        cellDetectable=1;
        %loop until the appropriate region is found, or no region can be
        %found
        while tooBig && cellDetectable
            currentThreshold=currentThreshold-thresholdStep;
            bw=logedgesmooth>currentThreshold;
            bwi=~bw;
            bwif=imfill(bwi,'holes');
            [bwb bwl]=bwboundaries(bwif);
            if t==startingpoints(n)%handles the case for the first frame in which this point is being tracked
                regionNum=bwl(r(n),c(n));
                regionArea=sum(sum(bwl==regionNum)); % adding the number of pixels within the current region to find area
                sizeChange=1;
            elseif nindex(t-1,n).PixelList(:,1)==0;%handles the case where cell has been lost
                cellDetectable=0;
                regionNum=0;
                regionArea=0;
                sizeChange=1;
            else
                px=nindex(t-1,n).PixelList(:,1)-c1; %get x pixels from previous frame KNOWN ISSUE: should correct for possible shift in r1,r2,c1,c2 between frames
                py=nindex(t-1,n).PixelList(:,2)-r1; %get y pixels from previous frame
                lind=sub2ind(size(bwl),py,px);  %convert pixels from xy to indices
                regionNum=mode(bwl(lind));
                if regionNum==0
                    overlapregion=bwl(lind);
                    overlapnz=find(overlapregion); 
                         if ~isempty(overlapnz)
                            regionNum=mode(overlapregion(overlapnz));  %find the region in the current bwl that overlaps most with the region identified for this point in the previous time point
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

            rvalw(t,n)=mean(currentRatio(clind));
            rvalwMC(t,n)=mean(currentRatioMC(clind));
            cfpvalw(t,n)=mean(currentCFP(clind));
            yfpvalw(t,n)=mean(currentYFP(clind));
            rfpvalw(t,n)=mean(currentRFP(clind));
            
            % calculate and store mean fret ratio for nuclear region
            nx=pln(regionNum).PixelList(:,1);
            ny=pln(regionNum).PixelList(:,2);
            nlind=sub2ind(size(bwl),ny,nx);

            rvaln(t,n)=mean(currentRatio(nlind));
            rvalnMC(t,n)=mean(currentRatioMC(nlind));
            cfpvaln(t,n)=mean(currentCFP(nlind));
            yfpvaln(t,n)=mean(currentYFP(nlind));
            rfpvaln(t,n)=mean(currentRFP(nlind));
            
            % calculate and store mean fret ratio for just the cytosolic donut region
            [CNintersect, in, ic]=intersect(nlind,clind);
            clind(ic)=[];

            rvalc(t,n)=mean(currentRatio(nlind));
            rvalcMC(t,n)=mean(currentRatioMC(nlind));
            cfpvalc(t,n)=mean(currentCFP(nlind));
            yfpvalc(t,n)=mean(currentYFP(nlind));
            rfpvalc(t,n)=mean(currentRFP(nlind));
            
            c(n)=floor(mean(cx));
            r(n)=floor(mean(cy));
            
            
        else
            nindex(t,n).PixelList=[0 0];
        end

        
    end
    
end

save(['data_xy' ppoints '.mat']);
