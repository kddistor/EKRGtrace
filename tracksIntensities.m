function [intvalue]=trackIntensities(namePre,namePost,tstr,channelnum,tmcube)

bx = size(tmcube,1);
by = size(tmcube,2);
timepoints = size(tmcube,3);

for t=1:timepoints
    for n=1:channelnum
        filename{n}=[namePre{n} tstr{t} namePost{n}];
        currentim(:,:,n)=imread(filename{n});
    end

    currentLM=tmcube(:,:,t);
    currentPL=regionprops(currentLM,'PixelList');
    for c=1:length(currentPL);
        
        pix=currentPL(c).PixelList;
        lind=sub2ind(size(currentLM),pix(:,2),pix(:,1));
        for n=1:channelnum
            current2D=currentim(:,:,n);
            intvalue(c,t,n)=mean(current2D(lind));
        end
    end
end
