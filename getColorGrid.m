function [ colorGrid ] = getColorGrid()
%GETCOLORGRID Summary of this function goes here
%   Detailed explanation goes here

colorGrid = zeros(32,32,3);
for x=1:32
    for y=1:32
        
        colorGrid(x,y,1) = x/32;
        colorGrid(x,y,2) = y/32;
        colorGrid(x,y,3) = ((32-x+32-y)/2)/32;
    end
end



end

