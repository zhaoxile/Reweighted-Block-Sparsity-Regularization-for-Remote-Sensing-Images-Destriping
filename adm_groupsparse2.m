function [s,ii,relchg]=adm_groupsparse2(I,opts)
%% ---the right version!!!!
%---date: 2016-5-10
[m,n]=size(I);numpat  =10*ones(1,40);%决定块大小等
C=getC(I);
D1=defDD1t;  %y-direction finite function
D2=defDD2t;  %x-direction finite function
Dt=defDDt;

%%%%--------------initialization----------%%%%
f=I;
s=zeros(m,n);  
p1=zeros(m,n);  %%!!!
p2=p1;
p3=p1;
lamda1=opts.lamda1;
lamda2=opts.lamda2;
beta1=opts.beta1;
beta2=opts.beta2;
beta3=opts.beta3;
tol=opts.tol;
maxitr=opts.maxitr;
%Denom=beta1*C.eigsD1tD1+beta2*eyes(m,n)+beta3*C.eigsD2tD2;  
Denom=beta3*C.eigsD1tD1+beta2*ones(m,n)+beta1*C.eigsD2tD2;%% eyes(m,n)

%%%%--------------finite diff-------------%%%%
D2s=D2(s);         %   d_x(s)
D1s=D1(f-s);       %   d_y(f-s)
%%%%--------------Main loop---------------%%%%
ii=0;
relchg1=1;
y=zeros(m,n);
relchg=[];r=zeros(n,m);
while relchg1> tol && ii<maxitr 
    V1=D2s+p1/beta1;
    V2=D1s+p3/beta3;
    %%%%----------x-subproblem------------%%%%
    x=sign(V1).*max(0,abs(V1)-1/beta1);
    %%%%----------z-subproblem------------%%%%
    z=sign(V2).*max(0,abs(V2)-lamda2/beta3);
    %%%%----------y-subproblem------------%%%%
    %%%%----------group sparse l_{2,1}----%%%%
    %for i=1:n
        %r=s(:,i)+p2(:,i)/beta2;
        %y(:,i)=r.*max(norm(r)-lamda1/beta2,0)/(norm(r)+eps);
    %end
    
    col_k   = 1:numpat(1);
    for i=1:col_k(end)
        r=s(:,i)+p2(:,i)/beta2;
        y(:,i)=r.*max(norm(r)-lamda1/beta2*1./( sqrt(sum(s(:,i).^2))+eps),0)/(norm(r)+eps);
    end
    for k = 2:length(numpat)
        col_k = (col_k(end)+1) : (col_k(end)+ numpat(k));
        for i=1:col_k(end)
        r=s(:,i)+p2(:,i)/beta2;
        y(:,i)=r.*max(norm(r)-lamda1/beta2*1./( sqrt(sum(s(:,i).^2))+eps),0)/(norm(r)+eps);
        end
    end

     %%%-------global sparse l_0--------%%%%%
%      V3=s+p2/beta2;
%      jj=find(abs(V3)>=sqrt(2*lamda1/beta2));
%      y(jj)=V3(jj);
 %%%%----------s-subproblem------------%%%%
    sp=s;
    temp1=beta3*D1(f)-beta3*z+p3;
    temp2=beta2*y-p2;
    temp3=beta1*x-p1;
    s1=Dt(temp1,temp3)+temp2;
    s2=fft2(s1)./(Denom+eps);
    s=real(ifft2(s2));
    %%%---------做投影------%%%
    u1=f-s;
    u1(u1>1)=1;
    u1(u1<0)=0;
    %%%---------做投影------%%%
    u2=f-sp;
    u2(u2>1)=1;
    u2(u2<0)=0;
    %%%%%%%%%%%%%%%%%%%%%%%
    relchg1=norm(u1-u2,'fro')/norm(u1,'fro');
    relchg = [relchg,relchg1];
    ii=ii+1;
    %%%%------------finit diff------------%%%%
    D2s=D2(s);
    D1s=D1(f-s);
    %%%%------------update p--------------%%%%
    p1=p1+1.618*beta1*(D2s-x);
    p2=p2+1.618*beta2*(s-y);
    p3=p3+1.618*beta3*(D1s-z);
    %beta_1 = min(beta_1*1.02,0.3);
    %beta_2 = min(beta_2*1.02,0.3);
    %beta_3 = min(beta_3*1.02,0.3);
end
%%%%--------------Subfunction-------------%%%%
function C=getC(I)
sizeI=size(I);
C.eigsD1tD1=abs(psf2otf([1,-1],sizeI)).^2;
C.eigsD2tD2=abs(psf2otf([1;-1],sizeI)).^2;
end
%%%%--------------Subfunction-------------%%%%
function D1=defDD1t
D1=@(U)ForwardD1(U);
end

function D2=defDD2t
D2=@(U)ForwardD2(U);
end

function Dt=defDDt
Dt= @(X,Y) Dive(X,Y);
end

function Dux=ForwardD1(U)
Dux=[diff(U,1,2),U(:,1)-U(:,end)];
end

function Duy=ForwardD2(U)
Duy=[diff(U,1,1);U(1,:)-U(end,:)];
end

function DtXY = Dive(X,Y)
DtXY = [X(:,end) - X(:, 1), -diff(X,1,2)];
DtXY = DtXY + [Y(end,:) - Y(1, :); -diff(Y,1,1)];
end
end