function [q2new,R] = Find_Best_Rotation(q1,q2)
% Assumes the starting points are fixed
% Kabsch algorithm 

[T,n] = size(q1);
A = q2'*q1;
[U,S,V] = svd(A);
if det(A) > 0
    S = eye(n);
else
    S = eye(n);
    S(:,end) = -S(:,end);
end

R = U*S*V';
q2new = q2*R;
