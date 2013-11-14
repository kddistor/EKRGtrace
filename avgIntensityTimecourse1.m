function [nameHCube] = avgIntensityTimecourse1(tpadding, ifpadded, tvec, separator_pos, order_pos, xys, xyvec, xypadding, basename, ch1n, ch2n, ch3n, ch4n, extension)
%   tpadding: 3 = 001;
%   ifpadded: 1 - padded, 2 - not padded.
%   tvec: '1:time'
%   separator: 1 - none, 2 - '-', 3 - '_'
%   order:  1 - 't...xy...c...', 2 - 't...c...xy...', 3 - 'xy...t...c...',4 - 'xy...c...t...', 5 - 'c...xy...t...', 6 - 'c...t...xy...'
%   xys: 's' or 'xy'
%   xyvec: '1:slidenumber'
%   xypadding: 3 = 001
%   basename: 'basename'
%   ch1n: '1st Channel'
%   ch2n: '2nd Channel'
%   ch3n: '3rd Channel'
%   ch4n: '4th Channel'
%   extension:  eg. 'tif' or 'TIF'

switch separator_pos
    case 1
        sepstr='';
    case 2
        sepstr='-';
    case 3
        sepstr='_';
end


switch ifpadded  
    case 1 %padded
        for i=1:length(tvec)
            tp=['000000' num2str(tvec (i))];
            tstr(i)={['t' tp((end-(tpadding-1)):end)]};
        end
    case 2 %not padded
        for i=1:length(tvec)
            tstr(i)={['t' num2str(tvec(i))]};
        end
end

switch ifpadded  
    case 1 %padded
        for i=1:length(xyvec)
            xyp=['000000' num2str(xyvec(i))];
            xystr(i)={[xys xyp((end-(xypadding-1)):end)]};
        end
    case 2 %not padded
        for i=1:length(xyvec)
            xystr(i)={[xys num2str(xyvec(i))]};
        end
end

for i=1:length(tvec)
    for j=1:length(xyvec)
        switch order_pos
            case 1 %t...xy...c...
                filenameCFP = strcat(basename, tstr(i), sepstr, xystr(j), sepstr, ch1n, extension);
                filenameYFP = strcat(basename, tstr(i), sepstr, xystr(j), sepstr, ch2n, extension);
                filenameRFP = strcat(basename, tstr(i), sepstr, xystr(j), sepstr, ch3n, extension);
                filenameNFP = strcat(basename, tstr(i), sepstr, xystr(j), sepstr, ch4n, extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
            case 2 %t...c....xy...
                filenameCFP = strcat(basename, tstr(i), sepstr, ch1n, sepstr, xystr(j), extension);
                filenameYFP = strcat(basename, tstr(i), sepstr, ch2n, sepstr, xystr(j), extension);
                filenameRFP = strcat(basename, tstr(i), sepstr, ch3n, sepstr, xystr(j), extension);
                filenameNFP = strcat(basename, tstr(i), sepstr, ch4n, sepstr, xystr(j), extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
            case 3 %xy...t...c...
                filenameCFP = strcat(basename, xystr(j), sepstr, tstr(i), sepstr, ch1n, extension);
                filenameYFP = strcat(basename, xystr(j), sepstr, tstr(i), sepstr, ch2n, extension);
                filenameRFP = strcat(basename, xystr(j), sepstr, tstr(i), sepstr, ch3n, extension);
                filenameCFP = strcat(basename, xystr(j), sepstr, tstr(i), sepstr, ch4n, extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
            case 4 %xy...c...t...
                filenameCFP = strcat(basename, xystr(j), sepstr, ch1n, sepstr, tstr(i), extension);
                filenameYFP = strcat(basename, xystr(j), sepstr, ch2n, sepstr, tstr(i), extension);
                filenameRFP = strcat(basename, xystr(j), sepstr, ch3n, sepstr, tstr(i), extension);
                filenameCFP = strcat(basename, xystr(j), sepstr, ch4n, sepstr, tstr(i), extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
            case 5 %c...xy...t...
                filenameCFP = strcat(basename,ch1n, sepstr, xystr(j), sepstr, tstr(i), extension);
                filenameYFP = strcat(basename,ch2n, sepstr, xystr(j), sepstr, tstr(i), extension);
                filenameRFP = strcat(basename,ch3n, sepstr, xystr(j), sepstr, tstr(i), extension);
                filenameNFP = strcat(basename,ch4n, sepstr, xystr(j), sepstr, tstr(i), extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
            case 6 %c...t...xy...
                filenameCFP = strcat(basename, ch1n, sepstr, tstr(i), sepstr, xystr(j), extension);
                filenameYFP = strcat(basename, ch2n, sepstr, tstr(i), sepstr, xystr(j), extension);
                filenameRFP = strcat(basename, ch3n, sepstr, tstr(i), sepstr, xystr(j), extension);
                filenameNFP = strcat(basename, ch4n, sepstr, tstr(i), sepstr, xystr(j), extension);
                nameMatrix1(i,j)=cellstr(filenameCFP);
                nameMatrix2(i,j)=cellstr(filenameYFP);
                nameMatrix3(i,j)=cellstr(filenameRFP);
                nameMatrix4(i,j)=cellstr(filenameNFP);
        end
    end
end

nameHCube(:,:,1) = nameMatrix1;
nameHCube(:,:,2) = nameMatrix2;
nameHCube(:,:,3) = nameMatrix3;
nameHCube(:,:,4) = nameMatrix4;
