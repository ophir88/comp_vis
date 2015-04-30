function [ MA ] = getLMS( option )
%GETLMS Summary of this function goes here
%       1 - XYZ scaling
%       2 - Bradford
%       3 - Von Kries

if (option == 1)
MA = eye(3);
end
if (option == 2)
MA = [0.8951 0.2664 -0.1614; -0.7502 1.7135 0.0367  ; 0.0389 -0.0685 1.0296];  
end
if(option == 3)
MA =  [0.4002400 0.7076 -0.0808100; -0.2263 1.16532 0.0457; 0 0 0.91822];

end

    
    
end

