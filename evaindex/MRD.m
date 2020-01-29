function mrd = MRD(stripI,destripI,pos,regionSize)
if nargin==3
        regionSize = 10; % set the default value of regionSize
end

rowPos = pos(1);
colPos = pos(2);
region1 = stripI(rowPos:rowPos+regionSize-1,colPos:colPos+regionSize-1);
region2 = destripI(rowPos:rowPos+regionSize-1,colPos:colPos+regionSize-1);
region1 = region1(:);
region2 = region2(:);
erro = abs(region2-region1);
rerro = sum(erro./(region1+eps));
mrd = rerro/(regionSize^2);
end