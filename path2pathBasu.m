function [enumeratePath,noNeuronPaths] = path2pathBasu(neuron1)

% This function decompose a neuron into a set of paths. next, it computes
% the concurrence and hierarchy values (check Path2Path by Basu et al.). 
% enumeratePath is a cell arry conatining all the paths of neuron1 with
% each path containing nodenumbers and corresponding cncurrence and hierarchy values.   


noNodes = size(neuron1,1);

%% find degree of nodes
degNeuron = zeros(noNodes,1);
for k = 2:noNodes
   degNeuron(neuron1(k,1)) = degNeuron(neuron1(k,1))+1;
   degNeuron(neuron1(k,7)) = degNeuron(neuron1(k,7))+1;
end
degNeuron(1) = sum(neuron1(:,7)==1);


%% find dendrite ends
nodeDendrite = (neuron1(:,2)==3)+ (neuron1(:,2)==4); 
nodeDegUnity = (degNeuron==1);
dendriteEnd = find((nodeDegUnity.*nodeDendrite)==1);
if dendriteEnd(1)==1
    dendriteEnd(1)=[];
end
noNeuronPaths = length(dendriteEnd);

clear nodeDendrite nodeDegUnity k

%% find bifurcations and multifurcations
bifurList = find(degNeuron(2:end)>=3)+1;  

%% path concurrence
concurList = zeros(noNodes,1);
concurList(dendriteEnd)=1;
for k = 1:size(dendriteEnd,1)
    pvt = dendriteEnd(k);
    concurList = pathConcurrence(neuron1,bifurList,concurList,pvt);
end
concurList(1)=0;

%% hierarchy 
hierarchyList = zeros(noNodes,1);
pvt = 1;
wCount = 1;
hierarchyList = pathHierarchy(neuron1,wCount,hierarchyList,dendriteEnd,pvt);

%% List of paths with hierarchy values and path concurrence
tmp = [];
for k = 1:noNeuronPaths
    pvt = dendriteEnd(k);
    while pvt ~=1
        tmp = [tmp; pvt concurList(pvt) hierarchyList(pvt)];
        pvt = neuron1(pvt,7);
    end
    tmp = [tmp; 1 concurList(1) hierarchyList(1)];
    enumeratePath{k} = tmp;
    tmp = [];
end
%enumeratePath
%noNeuronPaths

end