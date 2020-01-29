function icv = InverCoeffiVar(img,pos,regionSize)
%This function is used to compute the Inverse coefficient of variation(ICV)
% in image img. a regionSize x regionSize homogeneous regions were selected for ICV
% evalution.

% input:
%             img ---- the test img
%             pos ---- the coordinate of left-top point of the region
%             regionSize ---- the size of selected region
% output:
%             icv ---- the inverse coefficient of variation

% written by wangmin in 2014,10,26

if nargin==2
        regionSize = 10; % set the default value of regionSize
end

rowPos = pos(1);
colPos = pos(2);
region = img(rowPos:rowPos+regionSize-1,colPos:colPos+regionSize-1);
region = region(:);
Ra = mean(region);
Rsd = std(region,1);
icv = Ra/Rsd;

end

