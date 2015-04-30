function [ imgOut ] = applyL( imgWoD , Lmat, adaptationChoice )
%APPLYL Summary of this function goes here
%   Detailed explanation goes here




MA = getLMS(adaptationChoice);


% transform to LMS
[m, n, l] = size(imgWoD);
%reshape the matrix so we could multiply both martixes
imgLMS = reshape(imgWoD, m*n, l)';

imgLMS = MA * imgLMS;
%reshape back to the original size
imgLMS = reshape(imgLMS', [m, n, l]);

% apply L:

Lmat = Lmat*MA;

imgLMSL = reshape(imgLMS, m*n, l)';

imgLMSL = Lmat * imgLMSL;
%reshape back to the original size
imgLMSL = reshape(imgLMSL', [m, n, l]);


% transform back to XYZ

imgOut = reshape(imgLMSL, m*n, l)';

imgOut = inv(MA)* imgOut;
%reshape back to the original size
imgOut = reshape(imgOut', [m, n, l]);




end

