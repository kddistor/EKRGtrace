function [tmcube, lmcube, smcube]=quickTrack(namePre,namePost,tstr,trackChannel,sizeThresh)

minDiameter=sizeThresh(1);
maxDiameter=sizeThresh(2);
minNucArea=round(pi*minDiameter^2/4);
maxNucArea=round(pi*maxDiameter^2/4);
minFormfactor=0.8;
timepoints=length(tstr);
figure(1);
for t=1:timepoints
    t
    filename=[namePre{trackChannel} tstr{t} namePost{trackChannel}];
    im=imread(filename);
    level=graythresh(im);
    imt=im2bw(im,level);
    subplot(2,3,1),imshow(im,[]);
    subplot(2,3,2),imshow(imt);
    imD = bwdist(~imt);
%     D2=double(D).*double(Mt);
%     D2t=D2>(minDiameter/2);figure,imshow(D2t);
    subplot(2,3,3),imshow(imD,[]);

    imt=imfill(imt,'holes');
    CC = bwconncomp(imt, 4);
    S = regionprops(CC,'EquivDiameter','Area','Perimeter');
    nucArea=cat(1,S.Area);
    nucPerim=cat(1,S.Perimeter);
    nucEquiDiameter=cat(1,S.EquivDiameter);
    nucFormfactor=4*pi*nucArea./(nucPerim.^2);
    
    sizeScore=nucArea>minNucArea & nucArea<maxNucArea;
    shapeScore=nucFormfactor>minFormfactor;
    totalScore=sizeScore&shapeScore;
    
    lm=labelmatrix(CC);
    sm=lm;
    subplot(2,3,4),imshow(lm,[]);
    for k=1:length(totalScore)
        currentpix=lm==k;
        sm(currentpix)=totalScore(k)+1;
        
        
    end
    lmcube(:,:,t)=lm;
    smcube(:,:,t)=sm;
    size(lmcube);
    subplot(2,3,5),imshow(sm,[]);
    
end

tmcube=zeros(size(lmcube));
nextTMid=1;

%first pass through; connect only clear individual cells
for t=1:timepoints-1
    clm=lmcube(:,:,t);
    csm=smcube(:,:,t);
    ctm=tmcube(:,:,t);
    nlm=lmcube(:,:,t+1);
    nsm=smcube(:,:,t+1);
    ntm=tmcube(:,:,t+1);
    
    ncells=max(max(clm));
    
    for k=1:ncells
        currentpix=find(clm==k);
        if mode(csm(currentpix)==2)
            overlappix=nlm(currentpix);
            target=mode(overlappix);
            targetpix=find(nlm==target);
            targetscore=mode(nsm(targetpix));
            if targetscore==2
                %link 
                trackID=mode(ctm(currentpix));
                if trackID==0
                    ctm(currentpix)=nextTMid;
                    trackID=nextTMid;
                    nextTMid=nextTMid+1;
                end
                ntm(targetpix)=trackID;
            elseif targetscore==1
                %reset current label to 3
                csm(currentpix)=3;
            elseif targetscore==0
                %resetcurrent label to 4

            end
        end
    end
    if t==1
        tmcube(:,:,t)=ctm;
    end
    tmcube(:,:,t+1)=ntm; 
    
    
end

%second pass through; find likely merges; split them and add them to the
%existing tracks



