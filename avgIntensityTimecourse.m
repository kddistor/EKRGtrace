function [data1 data2 data3 data4]=avgIntensityTimecourse(tstr, namePre, namePost)

timepoints=1:length(tstr);
xyPoints=1:length(tstr);
threshold=20;

dataMat1=zeros(length(xyPoints),length(timepoints));
dataMat2=zeros(length(xyPoints),length(timepoints));
dataMat3=zeros(length(xyPoints),length(timepoints));

 for j=timepoints
    currentTstr=tstr{j}
    currentTstr;
    ji=str2num(currentTstr(2:end))
    
    for i=xyPoints
        img1Name=[namePre{1} tstr{j} namePost{1}];
        img2Name=[namePre{2} tstr{j} namePost{2}];
        currentImage1 = imread(img1Name);
        currentImage2 = imread(img2Name);
        background1=imopen(currentImage1,strel('disk',50));
        background2=imopen(currentImage2,strel('disk',50));
        currentImage1=currentImage1-background1;
        currentImage2=currentImage2-background2;
        ratioImage=currentImage1./currentImage2;
        tImage=currentImage1>threshold;

        currentCFPpix=currentImage1(tImage);
        currentYFPpix=currentImage2(tImage);
        currentRatiopix=ratioImage(tImage);
        
        data1(i,j)=mean(currentCFPpix);
        data2(i,j)=mean(currentYFPpix);
        data3(i,j)=mean(currentRatiopix);
        data4(i,j)=mean(currentYFPpix)/mean(currentCFPpix);
        
    end
end

data1=dataMat1;
data2=dataMat2;
data3=dataMat3;
