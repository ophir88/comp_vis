function [ Rimg ] = getLight( imageW , imageWo, flashCoeff , adaptationChoice )
%GETLIGHT 
%  imageW - image with flash
%  imageWo - image witout flash
%  flashCoeff - L of the flash
%  adaptationChoice:
%       0 - RGB
%       1 - XYZ, XYZ scaling
%       2 - XYZ, Bradford
%       3 - XYZ, Von Kries




epsilon = 0.00001;
% read images:
imgW = imread(imageW);
imgWo = imread(imageWo);

% get image size:
[rows cols dim] = size(imgW);
n = rows*cols;
% transform to double and linear adjustmant:
% imgWD = imgW;
% imgWoD = imgWo;

imgWD = im2double(imgW);
imgWoD = im2double(imgWo);
% imgWoD = imgWoD + epsilon;
% imgWoD(imgWoD==0)=0.001;
% imgWD = imgWD + epsilon;

% 
% %  fix colors:
% imgWD = colorFix(imgWD);
% imgWoD = colorFix(imgWoD);
% transform to LMS:



% image containing the flash: R(k1*L1 + k2*L2);
% removing the image wo the flash will leave us with R*k2*L2:

imgSub = imgWD - imgWoD;
% imgSub = imgSub+epsilon;
% figure;
% imshow(imgSub);

% get the relative R(red/blue) R(green/blue) 

% Rrg = (imgSub(:,:,1)/imgSub(:,:,2))*(flashCoeff(2)/flashCoeff(1));
Rrb = (imgSub(:,:,1)./imgSub(:,:,3))*(flashCoeff(3)/flashCoeff(1));
Rgb = (imgSub(:,:,2)./imgSub(:,:,3))*(flashCoeff(3)/flashCoeff(2));

% same for L channels:

% L1rg = (imgWoD(:,:,1)/imgWoD(:,:,2))/Rrg;
L1rb = (imgWoD(:,:,1)./imgWoD(:,:,3))./Rrb;
L1gb = (imgWoD(:,:,2)./imgWoD(:,:,3))./Rgb;


% clean L1rb from NAN and inf points:
L1rbInfCount = sum(sum(L1rb==Inf));
L1rbNaNCount = sum(sum(isnan(L1rb)'));
L1rbminInfCount = sum(sum(L1rb==(-Inf)));
L1rb(L1rb==Inf)=0;
L1rb(L1rb==(-Inf))=0;
L1rb(isnan(L1rb))=0;



% same for L1gb
L1gbInfCount = sum(sum(L1gb==Inf));
L1gbNaNCount = sum(sum(isnan(L1gb)'));
L1gbminInfCount = sum(sum(L1gb==(-Inf)));
L1gb(L1gb==Inf)=0;
L1gb(L1gb==(-Inf))=0;
L1gb(isnan(L1gb))=0;


% average L, remember to take the NAN and inf points out of the count:
L1b = 1;
L1r = sum((sum(L1rb))')/(n-L1rbInfCount-L1rbNaNCount-L1rbminInfCount);
L1g = sum((sum(L1gb))')/(n-L1gbInfCount-L1gbNaNCount-L1gbminInfCount);

Lmat = [1/L1r 0 0 ; 0 1/L1g 0 ; 0 0 1];

if(adaptationChoice>0)
    Rimg = applyL(imgWoD , Lmat, adaptationChoice);
    
else
    % apply the L transformation in a case of RGB:

Rimg = zeros(rows,cols,3);
Rimg(:,:,1) = imgWoD(:,:,1)./L1r;
Rimg(:,:,2) = imgWoD(:,:,2)./L1g;
Rimg(:,:,3) = imgWoD(:,:,3);
end

Rimg = imadjust(Rimg, stretchlim(Rimg),[]);


figure;

imshow(Rimg);


end

