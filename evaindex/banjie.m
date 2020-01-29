function [NonP_Stripe,S]   =  banjie(Ori,rate,mean)
%% 
%case1:
%%%%%%%%%%%%%%%%%%%%-----------Chang creat stripe noise---------%%%%%%
%在1——10里面随机产生初始列，然后以10为周期加条带噪声
%前面的列同时加上一个固定的数：mean
%后面的列同时减去一个固定的数：mean
%这样的效果就可以达到加的条带的秩为1
rand('seed',2);
[Row, Col] = size(Ori);
S=zeros(Row,Col);
Location = randperm(Col,round(rate*Col));
Location1 = randperm(Row,round(rate*Row));
for i=1:round(rate*Row)/2
S(1:Location1(i),Location(i))=mean;
end
for i=round(rate*Row)/2+1:round(rate*Row)
S(1:Location1(i),Location(i))=-mean;
end
NonP_Stripe=Ori+S;
%%
 %case2  ：   条带上的值相同，但是不同条带上的值不同(有正有负），这样也可以达到条带的秩为1
%  rand('seed',1);
% [Row, Col] = size(Ori);
% Location = randperm(Col,round(rate*Col));
% u=randi([0 100],1,length(Location));
% S=zeros(Row,Col);
% S(:,Location(1:round(rate*Col/2)))=S(:,Location(1:round(rate*Col/2)))...
%     + repmat(u(1:round(rate*Col/2)),Row,1);
% S(:,Location(round(rate*Col/2)+1:round(rate*Col)))=...
%            S(:,Location(round(rate*Col/2)+1:round(rate*Col))) - repmat(u(round(rate*Col/2)+1:length(Location)),Row,1);
%  NonP_Stripe=Ori+S;