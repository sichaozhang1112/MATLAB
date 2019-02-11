function [t,y] = Beeman(func,A,trange,IC)
f = @(t,y) A*y + func(t,y);
t0 = trange(1);
t1 = trange(2);
h = 1e-4;
t = t0 : h :t1;
y(:,1) = IC;
ydot(:,1) = f(t0,y(:,1));
len = length(A);

k1 = f(t(1),y(:,1));
k2 = f(t(1)+1/2*h,y(:,1)+h*1/2*k1);
k3 = f(t(1)+1/2*h,y(:,1)+h*1/2*k2);
k4 = f(t(1)+h,y(:,1)+h*k3);    
y(:,2) = y(:,1) + h/6*(k1+2*k2+2*k3+k4);
ydot(:,2) = f(t(2),y(:,2));

% Beeman's Algorithm
x(:,1) = y(1/2*len+1:end,1);
x(:,2) = y(1/2*len+1:end,2);

v(:,1) = y(1:1/2*len,1);
v(:,2) = y(1:1/2*len,2);

a(:,1) = ydot(1:1/2*len,1);
a(:,2) = ydot(1:1/2*len,2);

for nn = 2 : length(t)-1
    % Predictor
    x(:,nn+1) = x(:,nn) + v(:,nn)*h + 1/6*(4*a(:,nn)-a(:,nn-1))*h^2;
    v(:,nn+1) = v(:,nn) + 3/2*a(:,nn)*h - 1/2*a(:,nn-1)*h;
    y(:,nn+1) = [v(:,nn+1);x(:,nn+1)];
    ydot(:,nn+1) = f(t(nn+1),y(:,nn+1));
    a(:,nn+1) = ydot(1:1/2*len,nn+1);
    % Corrector
    x(:,nn+1) = x(:,nn) + v(:,nn)*h + 1/6*(a(:,nn+1)+2*a(:,nn))*h^2;
    v(:,nn+1) = 1/h * (x(:,nn+1) - x(:,nn) + 1/6*(2*a(:,nn+1)+a(:,nn))*h^2);
    y(:,nn+1) = [v(:,nn+1);x(:,nn+1)];
    ydot(:,nn+1) = f(t(nn+1),y(:,nn+1));
    a(:,nn+1) = ydot(1:1/2*len,nn+1);
end

y = [v;x];

end