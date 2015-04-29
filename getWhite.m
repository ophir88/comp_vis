function [ flashCoeff ] = getWhite( grayCard)
%GETWHITE Summary of this function goes here
%   grayCard- image of crayCard
%   XYZ: 0 for RGB, 1 for XYZ


%  read image
img = imread(grayCard);
% imgD = img;
%  transform to double
imgD = im2double(img);

% crop the gray card out of the image (basicaly just looked where the card 
% starts and ends in the image,
%  there is nothing sophisticated about those points.. :) ):
imgD = imgD(1041:2522, 661:1848 , :);

[rows cols dim] = size(imgD);
n = rows*cols;

%find the average gray color (it says RGB, but works just as well for LMS):
Rav = sum(sum(imgD(:,:,1))')/n;
Gav = sum(sum(imgD(:,:,2))')/n;
Bav = sum(sum(imgD(:,:,3))')/n;
allAv = (Rav + Gav + Bav)/(3*0.18);
% K = allAv/0.82;
% coefficiants to get each channel as close to the average:
Rcoeff = Rav/allAv;
Gcoeff = Gav/allAv;
Bcoeff = Bav/allAv;
% L of the flash:
flashCoeff = [Rcoeff , Gcoeff , Bcoeff];

% % show a color fix:
% imgDFix = imgD;
% imgDFix(:,:,1) = imgDFix(:,:,1)/flashCoeff(1);
% imgDFix(:,:,2) = imgDFix(:,:,2)/flashCoeff(2);
% imgDFix(:,:,3) = imgDFix(:,:,3)/flashCoeff(3);
% imgDFix = colorFix(imgDFix);
% imgDFix=im2uint8(imgDFix);
% figure;
% subplot(1,2,1);
% imgD=im2uint8(imgD);
% imshow(imgD);
% subplot(1,2,2);
% imshow(imgDFix);
's';
end


