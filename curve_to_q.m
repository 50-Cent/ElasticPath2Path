function q = curve_to_q(p,dt)
% SRVF transformation of coordinates. For details, check 
% Shape analysis of elastic curves in euclidean spaces (Srivastava et al.)

[T,n] = size(p);
for i = 1:n
    v(:,i) = gradient(p(:,i),dt);
end

for t = 1:T
    L(t) = sqrt(norm(v(t,:)));
    if L(t) > 0.0001
        q(t,:) = v(t,:)/L(t);
    else
        q(t,:) = v(t,:)*0.0001;
    end
end