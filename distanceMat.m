function [dst, pairList,pathDescriptor1,pathDescriptor2] = distanceMat(neuron1,neuron2, no_sample)
% This function computes the distance MATRIX between paths of neuron1 with
% that of neuron2. Each path is resampled to have no_sample. Concurrence values and hierarchy
% values are accordingly interpolated. The resampled path is then transformed via SRVF 
% followed by registration. The distance metric used here is taken from Path2Path by Basu et al.    



[pathDescriptor1, noPath1] = path2pathBasu(neuron1);
[pathDescriptor2, noPath2] = path2pathBasu(neuron2);
noPath1
noPath2
dt1 = mean(diff((0:no_sample)/(no_sample-1)));
dstMat = zeros(noPath1,noPath2);
for k = 1:noPath1
    path1 = pathDescriptor1{k};    
    loc1 = path1(:,1);
    coord1 = neuron1(loc1,3:5);
    % MATLAB resample routine is inconsistent with path sampling    
    coord1 = pathresample(coord1,no_sample,size(path1,1));    
    aa1 = interpolateConcurrence(coord1,path1, neuron1(loc1,3:5));
    bb1 = interpolateHierarchy(coord1,path1, neuron1(loc1,3:5));
    coord1 = curve_to_q(coord1,dt1); 
    for m = 1:noPath2        
        path2 = pathDescriptor2{m};
        loc2 = path2(:,1);
        coord2 = neuron2(loc2,3:5);      
        % MATLAB resample routine is inconsistent with path sampling
        coord2 = pathresample(coord2,no_sample,size(path2,1));                    
        aa2 = interpolateConcurrence(coord2,path2, neuron2(loc2,3:5));
        bb2 = interpolateHierarchy(coord2,path2, neuron2(loc2,3:5));
        coord2 = curve_to_q(coord2,dt1);                          %SRV              
        [~,TR] =  Find_Best_Rotation(coord1,coord2);
        cc =  compute1Norm(coord1,coord2,TR);        
        dd = sum((abs(aa1-aa2).*cc)./(0.001+sqrt(bb1.*bb2)));
        dstMat(k,m) = dd/no_sample;        
    end    
end
[dst, pairList] = distanceNeuron(dstMat);



end

