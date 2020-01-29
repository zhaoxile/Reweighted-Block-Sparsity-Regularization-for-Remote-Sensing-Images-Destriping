function [NonP_Stripe,S]   =  NonPeriodical_Simulated0_S(Ori,rate,mean)
%% 
%case1:
%%%%%%%%%%%%%%%%%%%%-----------Chang creat stripe noise---------%%%%%%
%在1——10里面随机产生初始列，然后以10为周期加条带噪声
%前面的列同时加上一个固定的数：mean
%后面的列同时减去一个固定的数：mean
%这样的效果就可以达到加的条带的秩为1
% rand('seed',1);
% [Row, Col] = size(Ori);
% S=zeros(Row,Col);
% Location = randperm(Col,round(rate*Col));
% S(:,Location(1:round(rate*Col/2)))=S(:,Location(1:round(rate*Col/2))) + mean;
% S(:,Location(round(rate*Col/2)+1:round(rate*Col)))=...
%            S(:,Location(round(rate*Col/2)+1:round(rate*Col))) - mean;
% NonP_Stripe=Ori+S;
 %%
 %case2  ：   条带上的值相同，但是不同条带上的值不同(有正有负），这样也可以达到条带的秩为1
 rand('seed',1);
[Row, Col] = size(Ori);
Location1 = randperm(Col,round(rate*Col));%随机生成需要加条带的列的位置
%u=randi([0 100],1,length(Location1));  %随机生成一个与Location长度相同的0到100之间的随机数向量



S=zeros(Row,Col);
% Location(1:round(rate*Col/2)) 取location的前一半 
%Location(round(rate*Col/2)+1:round(rate*Col)) 取Location的后一半
S(1:100,Location1(1:round(rate*Col/2)))= ...
S(1:100,Location1(1:round(rate*Col/2))) +mean;

%S(1:200,Location1(1:round(rate*Col/2))) + repmat(u(1:round(rate*Col/2)),200,1);
%S(201:400,Location1(round(rate*Col/2)+1:round(rate*Col)))= ...
%S(201:400,Location1(round(rate*Col/2)+1:round(rate*Col))) - repmat(u(round(rate*Col/2)+1:length(Location1)),200,1);

%S(:,Location(1:round(rate*Col/2)))=S(:,Location(1:round(rate*Col/2))) + repmat(u(1:round(rate*Col/2)),Row,1);
%S(:,Location(round(rate*Col/2)+1:round(rate*Col)))= S(:,Location(round(rate*Col/2)+1:round(rate*Col))) - repmat(u(round(rate*Col/2)+1:length(Location)),Row,1);
 NonP_Stripe=Ori+S;