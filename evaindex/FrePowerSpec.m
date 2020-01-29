function [fre,powerSpec] = FrePowerSpec(im)
%This function is used to compute image im's 
% Normalized Frequency(Norfre) and Power Spectrum under the axis

% input:
%         im ---- the object image

% output:
%         fre ---- vector that contains the Normalized Frequency
%         powerSpec ---- vector that contains the image's power spectrum
%%------------ÐÐÌõ´ø-----------------%%%
    m = size(im,1);
    rowNum = fix(m/2)+10;
%     rowNum = m;
    powerSpec = fft(im);
    powerSpec = abs(powerSpec);
    powerSpec = mean(powerSpec,2);
    powerSpec = powerSpec(1:rowNum);
    fre = (0:rowNum-1)/m;
    
end