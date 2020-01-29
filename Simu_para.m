clear all; close all
path(path,genpath(pwd));
load('MODIS.mat');
[NonP_Stripe,S]   =  banjie(I,0.5,0.5*255);
J=I+S;

J=J/255;%figure,imshow(J,[])
psnr0=psnr_fun(I/255,J);ssim0 = ssim_2009(I,J*255);
 psnr_com = 0;
 psnr=[];
 %tic
 for i=0.1
     for j=[0.03 0.05 0.07 0.1 0.3 0.5 0.7]%[0.03 0.05 0.07 0.1 0.3 0.5 0.7]%[0.001 0.01 0.1 1]
         for v=0%-4:1
opts.lamda1=i;% 0.01 0.4/20 0.2/10
opts.lamda2=j;% 0.1  0.1/20 0.08/10
opts.beta1=10^(v);  % 10 15 10-15
opts.beta2=10^(v);% 10   15 10-15
opts.beta3=10^(v);% 10   15 10-15 
opts.tol=1.e-4;% 1e-4
opts.maxitr=1000;% 100
%[s,ii]=group_vexsparse(I,opts);
tic
[s,ii,relchg]=adm_groupsparse2(J,opts);
toc
destriping=J-s;
destriping(destriping>1)=1;
destriping(destriping<0)=0;
%figure,imshow(destriping,[])
psnr1=psnr_fun(I/255,destriping)

if psnr1>psnr_com
    i1=i;j1=j;v1=v;psnr_com=psnr1;u_max=destriping;s_max=s;
end
psnr=[psnr;psnr1];
         end
     end
 end
 ssim_g = ssim_2009(I,u_max*255);

subplot(131),imshow(J,[])
subplot(132),imshow(I,[])
subplot(133),imshow(u_max,[min(I(:))/255 max(I(:))/255])