function visualMorphingNeuron(pairList,P1, P2,neuron1,neuron2, no_sample, rngvc, dstNeuron)
% This function creates a video file of morphing from neuron1 to neuron2.
% neuron1 is transformed to neuron2 
% By convention, P1 has large number of branches/paths than P2

%pairList

%% store the resampled locations of pair paths

for k = 1:size(pairList,1)
    pathNumber = pairList(k,1);
    path1 = P1{pathNumber};
    pathNumber = pairList(k,2);
    path2 = P2{pathNumber};
    clear pathNumber     
    
    %% path coordinates
    loc1 = path1(:,1);
    loc2= path2(:,1);   
    coord1 = neuron1(loc1,3:5);
    coord2 = neuron2(loc2,3:5);
    clear loc1 loc2
    
    %% sample path1 and path2    
    % MATLAB resample routine is inconsistent with path sampling
    pathrs1 = pathresample(coord1,no_sample,size(path1,1));
    pathrs2 = pathresample(coord2,no_sample,size(path2,1));   
    
    %% Note the samples in Path2 that will be morphed from Path1
    % NOTE:: after resampling the existing coordinates are also changed a bit
    path2Label = [];
    for kk = 1:size(coord2,1)        
        labelp = findLabelp(pathrs2, coord2(kk,:));        
        path2Label = [path2Label;labelp];        
    end
    
    %% Note the samples of Path1 in resampled Path1
    path1Label = [];
    for kk = 1:size(coord1,1)
        labelp = findLabelp(pathrs1, coord1(kk,:));
        path1Label = [path1Label;labelp];        
    end
    clear labelp xx yy zz 
    %% store 
    storePathList{k}{1} = [pathrs1 pathrs2];     % (100*(3+3))
    storePathList{k}{2} = path1Label;
    storePathList{k}{3} = path2Label;    
end
clear path2Label path1Label coord1 coord2

%% path morphing as a convex combination between SRV(pathrs1) and SRV(pathrs2)
path1assembly = [];
path2assembly = [];
dt = mean(diff((0:no_sample)/(no_sample-1)));
storeRotation = [];

path1dev = [];
path2dev = [];
for k = 1:size(pairList,1)
    tmp = storePathList{k}{1};   
    tpp1 = curve_to_q(tmp(:,1:3),dt);
    tpp2 = curve_to_q(tmp(:,4:6),dt);
    [~,TTR] = Find_Best_Rotation(tpp1,tpp2);
    
    path1bck = q_to_curve(tpp1,dt);
    path2bck = q_to_curve(tpp2,dt);
    rootshift1 = repmat(path1bck(end,:),no_sample,1);
    rootshift2 = repmat(path2bck(end,:),no_sample,1);
    path1dev = [path1dev path1bck-rootshift1-tmp(:,1:3)];
    path2dev = [path2dev path2bck-rootshift2-tmp(:,4:6)];
    
    storeRotation{k} = TTR;
    path1assembly = [path1assembly tpp1];     %100*[size(pairList,1)*3]
    path2assembly = [path2assembly tpp2];
end
clear tmp

%% _______________________ VISUALIZATION ____________________________%%
%% convex combination :: the morphing video will be at least (20+1) frames
currFolder = pwd;
AA = exist('videoRepo','dir');
if AA~=7
    mkdir videoRepo
end

v = VideoWriter(strcat(currFolder,'\','videoRepo','\vid1.avi'));
v.FrameRate = 3;
open(v);
%% set axis properties


%% record and save the transformation in video file
loops = 98;
noPair = size(pairList,1);
% color each path
rng(10)
colorMat = randi(noPair,noPair,3)/noPair;

for k = 1:loops+1
    tmpassembly = [];
    tmpQassembly = (1- (k-1)/loops)*path1assembly + ((k-1)/loops)*path2assembly;
    devList = (1- (k-1)/loops)*path1dev + ((k-1)/loops)*path2dev;
    
    for kk = 1:noPair
        tmp = q_to_curve(tmpQassembly(:,(kk-1)*3+1:3*kk),dt); %*inv(RotList{k})
        tmp = tmp - repmat(tmp(end,1:3),size(tmp,1),1);
        tmp = tmp-devList(:,(kk-1)*3+1:3*kk);
        tmpassembly = [tmpassembly tmp]; 
    end
    
    for kk = 1:noPair
        plot3(tmpassembly(:,(kk-1)*3+1),tmpassembly(:,(kk-1)*3+2),tmpassembly(:,3*kk),'-',...
            'Color',colorMat(kk,:),'LineWidth',2);
        xlim([rngvc(1)  rngvc(2)]);
        ylim([rngvc(3) rngvc(4)]);
        zlim([rngvc(5) rngvc(6)]);
        title(strcat('Ganglion to Granule ','(Dst :', num2str(dstNeuron),...
            ', Sample per Path: ',num2str(no_sample) ,')'))
        hold on     
    end
    view(20, 70)
    hold off
    frameI = getframe(gcf);
    writeVideo(v,frameI);
    
    pause(1/2)
    
end    
for mm = 1:10
   writeVideo(v,frameI); 
end
close(v);



end
%    tmpassembly = backTocurve(tmpQassembly, tmpDevassembly, dt, k);   
%    pause(2)
% vidF(loops+1) = struct('cdata',[],'colormap',[]);
