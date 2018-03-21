function coordOP = pathresample(coord1, r1, r2)
%Resample on a path
%   sequential biparition

[M,~] = size(coord1);
no_sample = floor(r1*(M/r2));

if M == no_sample
    coordOP= coord1;
elseif M < no_sample          % Interpolation    
    count = 0;
    k = 2;    
    while count <= no_sample
       newPt = (coord1(k-1,:)+coord1(k,:))/2;
       coord1 = [coord1(1:k-1,:);newPt;coord1(k:end,:)];
       if size(coord1,1)==no_sample
           break;
       end
       k = k+2;
       if k>2*M-1
           k=2;
           M=size(coord1,1);           
       end
       count = count+1;
    end
    coordOP=coord1;
elseif M > no_sample            % Downsample
    listloc = [];
    for k = 2:M-1
        listloc = [listloc; norm(coord1(k,:)-coord1(k-1,:))+norm(coord1(k+1,:)-coord1(k,:))];
    end 
    %listloc
    [~,IX] = sort(listloc,'ascend');
    loc2delete = IX(1:M-no_sample);
    coord1(loc2delete+1,:)=[];    
    coordOP = coord1;
end

end

