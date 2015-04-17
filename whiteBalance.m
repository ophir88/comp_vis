function [ output_args ] = whiteBalance( noFlash , Rimage )
%WHITEBALANCE Summary of this function goes here
%   Detailed explanation goes here

% min value in Rimage thresh:
imgWo = imread(noFlash);
imgWoD = im2double(imgWo);
imshow(Rimage);
[rows,cols,dim] = size(imgWoD);
n = rows*cols;
L1 = imgWoD./Rimage;
L1Rav = sum(sum(L1(:,:,1))')/n;
L1Gav = sum(sum(L1(:,:,2))')/n;
L1Bav = sum(sum(L1(:,:,3))')/n;
resultImg = zeros(rows,cols,3);
resultImg(:,:,1) = imgWoD(:,:,1)/L1Rav;
resultImg(:,:,2) = imgWoD(:,:,2)/L1Gav;
resultImg(:,:,3) = imgWoD(:,:,3)/L1Bav;





imshow(resultImg);

% L1R = mean(L1(:,:,1));
's';
end

