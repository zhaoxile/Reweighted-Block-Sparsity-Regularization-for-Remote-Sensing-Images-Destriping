function NR  = NoiseReduction(noisePS,denoisePS,noisepos)
%This function is used to compute the noise reduction(NR) between striped
%image and destriped image.

% input:
%           noisePS ---- the power spectrum of noise image
%           denoisePS ---- the power spectrum of denoise image
%           noisepos ---- noise positions in the power spectrum.

% ouput:
%           NR ---- noise reduction


% written by wangmin in 2014,10,24

[m1,n1] = size(noisePS);
[m2,n2] = size(denoisePS);
if m1~=m2 || n1~=n2
    error('the size of noisePS and denoisePS are not same, please check it over !')
end
if nargin==2
        noisepos = 41:40:201; % set the default value of noisepos
end

Nstrip = sum(noisePS(noisepos));
Ndestrip = sum(denoisePS(noisepos));
NR = Nstrip/Ndestrip;

end