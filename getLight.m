function [ output_args ] = getLight( imageW , imageWo, flashCoeff )
%GETLIGHT Summary of this function goes here
%   Detailed explanation goes here


% get image size:
[rows cols dim] = size(imageW);
n = rows*cols;

% read images:
imgW = imread(imageW);
imgWo = imread(imageWo);

% transform to double and linear adjustmant:

imgWD = im2double(imgW);
imgWoD = im2double(imgWo);

syms a b

maxVal = max(max(max(imgWD)));
minVal = min(min(min(imgWD)));

eq1 = 1==a*maxVal+b;
eq2 = 0 ==a*minVal+b;
sol = solve(eq1,eq2);
a = double(sol.a);
b = double(sol.b);

imgWD = a*imgWD + b;


syms c d
maxVal = max(max(max(imgWoD)));
minVal = min(min(min(imgWoD)));

eq2 = 1==c*maxVal+d;
eq3 = 0 ==c*minVal+d;
sol = solve(eq2,eq3);
c = double(sol.c);
d = double(sol.d);

imgWoD = a*imgWoD + b;

% image containing the flash: R(k1*L1 + k2*L2);
% removing the image wo the flash will leave us with R*k2*L2:

imgSub = imgWD - imgWoD;
imshow(imgSub);



end

