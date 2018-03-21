function p = q_to_curve(q,dt)
% Inverse SRVF transformation of coordinates. For details, check 
% Shape analysis of elastic curves in euclidean spaces (Srivastava et al.)



q = q';
[n,T] = size(q);

for i = 1:T
    qnorm(i) = norm(q(:,i));
end

p(1,:) = cumsum(q(1,:).*qnorm)*dt;
p(2,:) = cumsum(q(2,:).*qnorm)*dt;
p(3,:) = cumsum(q(3,:).*qnorm)*dt;

p = p';
% for i = 1:n
%     p(i,:) = cumtrapz(q(i,:).*qnorm)*dt;
% end
% p = p';