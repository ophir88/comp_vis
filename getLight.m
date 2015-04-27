function [ Rimg ] = getLight( imageW , imageWo, flashCoeff )
%GETLIGHT Summary of this function goes here
%   Detailed explanation goes here


% read images:
imgW = imread(imageW);
imgWo = imread(imageWo);

% transform to double and linear adjustmant:

imgWD = im2double(imgW);
imgWoD = im2double(imgWo);

syms a b c d

maxVal = max(max(max(imgWD)));
minVal = min(min(min(imgWD)));

eq1 = 1==a*maxVal+b;
eq2 = 0 ==a*minVal+b;
sol = solve(eq1,eq2);
aW = double(sol.a);
bW = double(sol.b);

maxVal = max(max(max(imgWoD)));
minVal = min(min(min(imgWoD)));

eq1 = 1==c*maxVal+d;
eq2 = 0 ==c*minVal+d;
sol = solve(eq1,eq2);
aWo = double(sol.c);
bWo = double(sol.d);

imgWD = aW*imgWD + bW;
imgWoD = aWo*imgWoD + bWo;

imgWD = imgWD.^(1/2.2);
imgWoD = imgWoD.^(1/2.2);
imshow(imgWD);
imshow(imgWoD);

% get image size:
[rows cols dim] = size(imgW);
n = rows*cols;

% image containing the flash: R(k1*L1 + k2*L2);
% removing the image wo the flash will leave us with R*k2*L2:


imgSub = imgWD - imgWoD;
figure;
imshow(imgSub);
% found = 0;
% maxIndex = 0
% for i = 1: min(rows,cols)
%     if found == 1
%         break;
%     end
% 
%     if ~isempty(find(imgSub(1:i,1:1,:) == 0))
%         maxIndex = i;
%         found = 1 ;
%         break;
%     else
%         'b';
%     end
% end
% partImgSub = imgSub(1:maxIndex,1:maxIndex,:);
% lineari transform both images to [0,1]:


% syms a b
%
% maxVal = max(max(max(imgSub)));
% minVal = min(min(min(imgSub)));
%
% eq1 = 1==a*maxVal+b;
% eq2 = 0 ==a*minVal+b;
% sol = solve(eq1,eq2);
% a = double(sol.a);
% b = double(sol.b);
%
% imgSub = a*imgSub + b;
%
% syms a b
%
% maxVal = max(max(max(imgSub)));
% minVal = min(min(min(imgSub)));
%
% eq1 = 2==a*maxVal+b;
% eq2 = 1 ==a*minVal+b;
% sol = solve(eq1,eq2);
% a = double(sol.a);
% b = double(sol.b);
%
% imgSub = a*imgSub + b;

% get the relativeness of L:

% Rrg = (imgSub(:,:,1)/imgSub(:,:,2))*(flashCoeff(2)/flashCoeff(1));
Rrb = (imgSub(:,:,1)./imgSub(:,:,3))*(flashCoeff(3)/flashCoeff(1));
Rgb = (imgSub(:,:,2)./imgSub(:,:,3))*(flashCoeff(3)/flashCoeff(2));


% % turn back:
% Rrb = Rrb/a - b;
% Rgb = Rgb/a - b;


% L1rg = (imgWoD(:,:,1)/imgWoD(:,:,2))/Rrg;
L1rb = (imgWoD(:,:,1)./imgWoD(:,:,3))./Rrb;
L1gb = (imgWoD(:,:,2)./imgWoD(:,:,3))./Rgb;

% clean L1rb
L1rbInfCount = sum(sum(L1rb==Inf));
L1rbNaNCount = sum(sum(isnan(L1rb)'));
L1rbminInfCount = sum(sum(L1rb==(-Inf)));
L1rb(L1rb==Inf)=0;
L1rb(L1rb==(-Inf))=0;
L1rb(isnan(L1rb))=0;

% clean L1gb
L1gbInfCount = sum(sum(L1gb==Inf));
L1gbNaNCount = sum(sum(isnan(L1gb)'));
L1gbminInfCount = sum(sum(L1gb==(-Inf)));
L1gb(L1gb==Inf)=0;
L1gb(L1gb==(-Inf))=0;
L1gb(isnan(L1gb))=0;

L1b = 1;
L1r = sum((sum(L1rb))')/(n-L1gbInfCount-L1gbNaNCount-L1gbminInfCount);
L1g = sum((sum(L1gb))')/(n-L1gbInfCount-L1gbNaNCount-L1gbminInfCount);



% for each pixel, we will look for the most relevant R:

% imshow(imgSub);
% imshow(colorGrid);

Rimg = zeros(rows,cols,3);
Rimg(:,:,1) = imgWoD(:,:,1)./L1r;
Rimg(:,:,2) = imgWoD(:,:,2)./L1g;
Rimg(:,:,3) = imgWoD(:,:,3);

averageMax = sum(sum(max(Rimg))/cols)/3;
averageMin = sum(sum(min(Rimg))/cols)/3;

% % % maxAverage = 
% % aveR = sum(sum(Rimg(:,:,1))')/n;
% % aveG = sum(sum(Rimg(:,:,2))')/n;
% % aveB = sum(sum(Rimg(:,:,3))')/n;
% % averageAll = (aveR+aveG+aveB)/3;
% % % coeff = 0.5/averageAll;
% 's';
% 
syms e f
% 
% maxVal = averageAll;
% minVal = 0;

eq1 = 1==e*averageMax+f;
eq2 = 0 ==e*averageMin+f;
sol = solve(eq1,eq2);
a = double(sol.e);
b = double(sol.f);

Rimg = a*Rimg + b;
Rimg = (Rimg.^(1/2.2));
Rimg = im2uint8(Rimg);
% Rimg = Rimg*coeff;

figure;
figure;
subplot(2,2,1);
imshow(imgWoD);
subplot(2,2,2);
imshow(imgWD);
subplot(2,2,3);
imshow(Rimg);


end

