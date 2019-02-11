function [t,y] = RK4(func,A,trange,IC,h)
f = @(t,y) A*y + func(t,y);
t0 = trange(1);
t1 = trange(2);
% h = 1e-4;
t = t0 : h :t1;
y(:,1) = IC;

for nn = 1 : length(t)-1
    k1 = f(t(nn),y(:,nn));
    k2 = f(t(nn)+1/2*h,y(:,nn)+h*1/2*k1);
    k3 = f(t(nn)+1/2*h,y(:,nn)+h*1/2*k2);
    k4 = f(t(nn)+h,y(:,nn)+h*k3);    
    y(:,nn+1) = y(:,nn) + h/6*(k1+2*k2+2*k3+k4);   
end

end