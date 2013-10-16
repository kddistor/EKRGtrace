%%%%%%%%%%%%%%%%%%%%%%%%%
%                       
%   ERKGtrace           
%   by Kevin Distor and John Albeck 
%   University of California - Davis
%                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Description                                                              
%       Creates avi file of movie with overlayed tracks.                                                                         
%                                                                         
%                                                                                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Dependencies
%           -Matlab current folder should be F:\livecell-part1
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function OverlayTracksObjects (namelist, cbound, r1, c1);
%Loop through Frames
    vidObj = VideoWriter([namelist{1} '.avi']);           %Name
    open(vidObj);  
for t=1:size(cbound,1)
    currentim=imread(namelist{t});
    figure(1), imshow(currentim,[]);
    for c=1:size(cbound,2)
        mycell = cbound(t,c);
        if isempty(mycell{1})                     %case of empty cell 
            continue
        else
            dim=mycell{1};
            dim2 = cat(2, dim(:,1)+r1,dim(:,2)+c1);
            hold on, plot(dim2(:,2),dim2(:,1),'-');
            hold on, text(min(dim2(:,2)),min(dim2(:,1)),num2str(c),'Color','Red','FontSize',12);
        end 
    end
    set(0,'CurrentFigure',1);
    frame = getframe;
    writeVideo(vidObj,frame)
end
close(vidObj);
