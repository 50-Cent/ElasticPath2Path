function opArray = interpolateHierarchy(coord,path,baseCoord)
% coord is the ordered resampled coordinates of a path.
% baseCoord is the ordered coordinates of that path from the input file.
% The coordinates between two consecutive baseCoords with Hierarchy
% values h_1 and h_2 (c_1 is closer to the root node)
% are assigned h_2.
opArray = zeros(size(coord,1),1);
hieVal = path(:,3);
for k =1:size(baseCoord,1)
    labelp = findLabelp(coord,baseCoord(k,:));
    opArray(labelp) = hieVal(k);
end

for k = 2:size(coord,1)
   if opArray(k)==0
       opArray(k) = opArray(k-1);
   end
end

end

