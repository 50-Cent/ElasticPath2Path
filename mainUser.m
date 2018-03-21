clc
clear all

disp('sample path:')
disp('~\sampleData\neuron_nmo')
prompt = 'Please enter the file path :-> ';
str = input(prompt,'s');
neuronData = readInput(str);
len = length(neuronData);
disp(strcat('Total number of neurons in the file :->',num2str(len)))

prompt = 'Enter two neurons to find distance';
disp(prompt)
prompt = 'first neuron?';
str1 = input(prompt,'s');
prompt = 'second neuron?';
str2 = input(prompt,'s');
neuron1 = cell2mat(neuronData{str2num(str1)});
neuron2 = cell2mat(neuronData{str2num(str2)});

prompt = 'total sample on each path';
str3 = input(prompt,'s');

%% Fix root at (0,0,0):: translation factor
root1 = neuron1(1,3:5);
root2 = neuron2(1,3:5);
neuron2(:,3:5) = neuron2(:,3:5)- repmat(root2,size(neuron2,1),1);
neuron1(:,3:5) = neuron1(:,3:5)- repmat(root1,size(neuron1,1),1);

clear root1 root2

%% distance matrix of paths between two neurons
tic
[dst,pairList,pathDescriptor1, pathDescriptor2] = distanceMat(neuron1,neuron2,str2num(str3));
toc
disp('Distance')

%% visualization of the morphing process
%% which one is larger
PP1 = length(pathDescriptor1);
PP2 = length(pathDescriptor2);
if PP1 < PP2
   tmp = neuron1;
   neuron1 = neuron2;
   neuron2 = tmp;
   tmp = pathDescriptor1;
   pathDescriptor1 = pathDescriptor2;
   pathDescriptor2 = tmp;
   tmp = pairList(:,1);
   pairList(:,1)=pairList(:,2);
   pairList(:,2)=tmp;
end
disp('NEURON MORPHING')

% The morphing is always from a larger neuron to a smaller neuron [CONVENTION TAKEN]
xup = max(max(neuron1(:,3)),max(neuron2(:,3)));
xlo = min(min(neuron1(:,3)),min(neuron2(:,3)));
yup = max(max(neuron1(:,4)),max(neuron2(:,4)));
ylo = min(min(neuron1(:,4)),min(neuron2(:,4)));
zup = max(max(neuron1(:,5)),max(neuron2(:,5)));
zlo = min(min(neuron1(:,5)),min(neuron2(:,5)));
rangeVector = [xlo xup ylo yup zlo zup];

clear xlo xup ylo yup zlo zup
%% Morphing
visualMorphingNeuron(pairList,pathDescriptor1,pathDescriptor2,neuron1,neuron2,str2num(str3),rangeVector,dst);


clear  len  neuronData prompt str str1 str2 str3 pathDescriptor1 pathDescriptor2 tmp

%%_____________________ END PROGRAM ________________________________%%




%% Extra code

%% visualization of the path correspondences
% visualPathCorrespondence(neuron1,neuron2,pairList,pathDescriptor1, pathDescriptor2, 'Y');