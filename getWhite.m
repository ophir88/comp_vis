function [ flashCoeff ] = getWhite( grayCard )
%GETWHITE Summary of this function goes here
%   Detailed explanation goes here


img = imread(grayCard);
[rows cols dim] = size(img);
n = rows*cols;

imgD = im2double(img);
syms a b

maxVal = max(max(max(imgD)));
minVal = min(min(min(imgD)));

eq1 = 1==a*maxVal+b;
eq2 = 0 ==a*minVal+b;
sol = solve(eq1,eq2);
a = double(sol.a);
b = double(sol.b);

imgD = a*imgD + b;
imgD = imgD.^(1/2.2);
%get average of each color:

Rav = sum(sum(imgD(:,:,1))')/n;
Gav = sum(sum(imgD(:,:,2))')/n;
Bav = sum(sum(imgD(:,:,3))')/n;
allAv = (Rav + Gav + Bav)/3;
K = allAv/0.82;
Rcoeff = Rav/allAv;
Gcoeff = Gav/allAv;
Bcoeff = Bav/allAv;
flashCoeff = [Rcoeff , Gcoeff , Bcoeff]*K;
imgDFix = imgD;
imgDFix(:,:,1) = imgDFix(:,:,1)/flashCoeff(1);
imgDFix(:,:,2) = imgDFix(:,:,2)/flashCoeff(2);
imgDFix(:,:,3) = imgDFix(:,:,3)/flashCoeff(3);
imgDFix=im2uint8(imgDFix);
figure;
subplot(1,2,1);
imgD=im2uint8(imgD);
imshow(imgD);
subplot(1,2,2);
imshow(imgDFix);
's';
end


