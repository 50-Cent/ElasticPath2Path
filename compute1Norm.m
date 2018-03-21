function cc =  compute1Norm(coord1,coord2,TR)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

coord2 = coord2*TR;
cc = [];
for k = 1:size(coord1,1)
    cc = [cc ;norm(coord1-coord2,1)];
end

end

