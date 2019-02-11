function [t,y] = AM2(func,A,trange,IC)
f = @(t,y) A*y + func(t,y);
t0 = trange(1);
t1 = trange(2);
h = 1e-4;
t = t0 : h :t1;
y(:,1) = IC;
len = length(A);

for nn = 1 : length(t)-1  
    y(:,nn+1) = (eye(len)-h/2*A)\((eye(len)+h/2*A)*y(:,nn) + h/2*(func(t(nn),y(:,nn))+func(t(nn+1),y(:,nn))));   
end

end