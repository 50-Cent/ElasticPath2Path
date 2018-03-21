function [dst,pairList] = distanceNeuron(dstMat)

[M,N] = size(dstMat);
statusSwap = 0;
if M>N
    dstMat = dstMat';    
    statusSwap = 1;
end
[M,N] = size(dstMat);           % M < N always

%% append zero rows (M workers + (N-M) dummy :: N jobs)
dstMat = [dstMat;zeros(N-M,N)];
[pairL, dst] = munkres(dstMat);
dst = dst/M;
pairList = pairL(1:M);

%size(pairList)
if statusSwap == 0
    pairList = [(1:M)' pairList'];
else
    pairList = [pairList' (1:M)'];
end

end

