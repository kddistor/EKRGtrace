function [coords] = autofindpoint(M,maxI,invertLog,sizeThres)

H = fspecial('unsharp');
M = imfilter(M,H,'replicate');
if invertLog
    M = ((maxI)-1)-M;
end


minNucDiameter=sizeThres(1);
maxNucDiameter=sizeThres(2);
minFormfactor=0.5;
im=im2double(M);

maxNucArea=round(pi*maxNucDiameter^2/4);

combined_bw = zeros(size(M));
testSet = linspace(1.4,4.5,10);

for s = 1:length(testSet)
    
    [im2,thresh]  = edge(im,'canny',0,testSet(s));
    im3 = ~im2;
    bw=im3-bwareaopen(im3,maxNucArea,4);
    bw=imfill(bw,'holes');
    CC = bwconncomp(bw, 8);
    S = regionprops(CC,'EquivDiameter','Area','Perimeter');
    nucArea=cat(1,S.Area);
    nucPerim=cat(1,S.Perimeter);
    nucEquiDiameter=cat(1,S.EquivDiameter);
    nucFormfactor=4*pi*nucArea./(nucPerim.^2);
    L = labelmatrix(CC);
    BW2 = ismember(L, find(nucEquiDiameter >= minNucDiameter & ...
        nucEquiDiameter < maxNucDiameter & ...
        nucFormfactor>minFormfactor));
    
    %if sum(BW2(:)) > 0
    combined_bw = combined_bw | BW2;
    %end
end


%imshow(BW);
S = regionprops(combined_bw,'Centroid');
coords = zeros(length(S),2);
for i=1:length(S)
    coords(i,:) = S(i).Centroid;
end
