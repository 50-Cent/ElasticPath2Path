function labelp = findLabelp(pathrs1, pvt)
% find the index of pvt in pathrs1. 

for k =1:size(pathrs1,1)
    if pathrs1(k,1)==pvt(1) && pathrs1(k,2)==pvt(2) && pathrs1(k,3)==pvt(3)
       labelp = k; 
    end
end

