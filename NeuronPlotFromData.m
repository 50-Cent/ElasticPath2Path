function NeuronPlotFromData(inputData)
% It does not take the file path like Neuron3DPlot.m. Rather it takes
% the input data in N*7 matrix, where N = number of samples.

wMax = max(inputData(3:end,6));
wMin = min(inputData(3:end,6));
tmp = 2*(inputData(:,6)-wMin)/(wMax-wMin)+0.5;
inputData(:,6) = tmp;

totalNode = inputData(end,1);
figure,plot3(inputData(1,3),inputData(1,4),inputData(1,5),'r','MarkerSize',10);view(0,90)

hold on
for k = 2:totalNode
   pt1 = inputData(k,3:5);
   pt2 = inputData(inputData(k,7),3:5);
   pt = [pt1;pt2];   
   if inputData(k,2)==1
       plot3(pt(:,1),pt(:,2),pt(:,3),'-r','LineWidth',5*inputData(k,6));       
   elseif inputData(k,2)==2
       plot3(pt(:,1),pt(:,2),pt(:,3),'-m','LineWidth',5*inputData(k,6));       
   elseif inputData(k,2)==3
       plot3(pt(:,1),pt(:,2),pt(:,3),'-g','LineWidth',5*inputData(k,6));       
   elseif inputData(k,2)==4
       plot3(pt(:,1),pt(:,2),pt(:,3),'-y','LineWidth',5*inputData(k,6));       
   elseif inputData(k,2)==5
       plot3(pt(:,1),pt(:,2),pt(:,3),'-b','LineWidth',5*inputData(k,6));       
   elseif inputData(k,2)==6
       plot3(pt(:,1),pt(:,2),pt(:,3),'-k','LineWidth',5*inputData(k,6));       
   end 
   xlim([-70 70]);
   ylim([-70 70]);
   zlim([-70 70]);
    
   hold on
end
hold off


end

