function [data1 data2 data3 data4]=avgIntensityTimecourse2(nameHCube)

ndim=1:size(nameHCube,3);
timepoints=1:size(nameHCube,1);
xyPoints=1:size(nameHCube,2);
threshold=20;


for j=timepoints
    for i=xyPoints
        for k=ndim
            imgName=nameHCube{j,i,k};
            currentImage = imread(imgName);
            background1=imopen(currentImage,strel('disk',50));
            currentImage=currentImage-background1;
            imgBlock(:,:,k)=currentImage;
        end
        
        currentCFPimage=imgBlock(:,:,1);
        currentYFPimage=imgBlock(:,:,2);
        ratioImage=imgBlock(:,:,1)./imgBlock(:,:,2);
        tImage=imgBlock(:,:,1)>threshold;
        
        currentCFPpix=currentCFPimage(tImage);
        currentYFPpix=currentYFPimage(tImage);
        currentRatiopix=ratioImage(tImage);
        
        data1(i,j)=mean(currentCFPpix);
        data2(i,j)=mean(currentYFPpix);
        data3(i,j)=mean(currentRatiopix);
        data4(i,j)=mean(currentYFPpix)/mean(currentCFPpix);
        
    end
end
save[['IntensityData' currentImage '.mat']);
