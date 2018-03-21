function tmpassembly = backTocurve(tmpQassembly, devList, dt, figNum)

[~,N] = size(tmpQassembly);
noPair = N/3;
tmpassembly = [];
for k = 1:noPair
    tmp = q_to_curve(tmpQassembly(:,(k-1)*3+1:3*k),dt); %*inv(RotList{k})
    tmp = tmp - repmat(tmp(end,1:3),size(tmp,1),1);
    tmp = tmp-devList(:,(k-1)*3+1:3*k);
    tmpassembly = [tmpassembly tmp];    
end

%% color each pair
rng(10)
colorMat = randi(noPair,noPair,3)/noPair;
figure(figNum),
for k = 1:noPair
    plot3(tmpassembly(:,(k-1)*3+1),tmpassembly(:,(k-1)*3+2),tmpassembly(:,3*k),'-',...
        'Color',colorMat(k,:),'LineWidth',2);
    xlim([-70  70]);
    ylim([-70 70]);
    zlim([-70 70]);
    hold on     
end
view(90,90)

hold off

end

