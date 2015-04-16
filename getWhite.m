function [ imgD ] = getWhite( grayCard )
%GETWHITE Summary of this function goes here
%   Detailed explanation goes here


img = imread(grayCard);
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

end

