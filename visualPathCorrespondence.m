function visualPathCorrespondence(neuron1,neuron2,pairList,pathDescriptor1, pathDescriptor2, commenT)

[M,~] = size(pairList);

rng(10);
colorMat = randi(M,M,3)/M;

figure,
inputData1 = neuron1;
totalNode1 = inputData1(end,1);
for k= 2:totalNode1
   pt1 = inputData1(k,3:5);
   pt2 = inputData1(inputData1(k,7),3:5);
   pt = [pt1;pt2];
   plot3(pt(:,1),pt(:,2),pt(:,3),'-k','LineWidth',2)
   hold on
end
for k=1:M
    pathNo = pairList(k,1);
    path1 = pathDescriptor1{pathNo};
    label1 = path1(:,1);
    loc1 = neuron1(label1,3:5);
    plot3(loc1(:,1),loc1(:,2),loc1(:,3),'-','Color',colorMat(k,:),'LineWidth',4 )
    hold on
end
view(0,90)
hold off

if commenT == 'Y'
    figure(2)
    inputData2 = neuron2;
    totalNode2 = inputData2(end,1);
    for k= 2:totalNode2
       pt1 = inputData2(k,3:5);
       pt2 = inputData2(inputData2(k,7),3:5);
       pt = [pt1;pt2];
       plot3(pt(:,1),pt(:,2),pt(:,3),'-k','LineWidth',1)
       hold on
    end
    for k=1:M
        pathNo = pairList(k,2);
        path2 = pathDescriptor2{pathNo};
        label2 = path2(:,1);
        loc2 = neuron2(label2,3:5);
        plot3(loc2(:,1),loc2(:,2),loc2(:,3),'-','Color',colorMat(k,:),'LineWidth',4 )
        hold on
    end
    view(0,90)
    hold off
end
end

