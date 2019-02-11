%
%% MECH 505 - Homework 2
%% Sichao Zhang, S01276479
%
%% Problem 3
%% Function Definition
A = [1,0,0,0,0,0;
     0,1,0,0,0,0;
     0,0,1,0,0,0;
     0,0,0,1,0,0;
     0,0,0,0,2,0;
     0,0,0,0,0,4];
B = [0,0,0,-1,0,0;
     0,0,0,0,-1,0;
     0,0,0,0,0,-1;
     10,-10,0,0,0,0;
     -10,30,-20,0,0,0;
     0,-20,50,0,0,0;];
C = [0;0;0;1;0;0];
m_a = [1,0,0;
     0,2,0;
     0,0,4];
m_b = [10,-10,0;
     -10,30,-20;
     0,-20,50];
m_c = [1;0;0];
N = 1e3 : 1e3 : 1e5;
dt = 15./N;
getk = @(y,t) inv(A)*(C*sin(2*pi*t)-B*y);
%
%% RK4
for nn = 1 : length(N)
    y = zeros(6,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    for ii = 1 : N(nn)
        k_1 = getk(y(:,ii),t(ii));
        k_2 = getk(y(:,ii)+dt(nn)*k_1/2,t(ii)+dt(nn)/2);
        k_3 = getk(y(:,ii)+dt(nn)*k_2/2,t(ii)+dt(nn)/2);
        k_4 = getk(y(:,ii)+dt(nn)*k_3,t(ii)+dt(nn));
        y(:,ii+1) = y(:,ii) + dt(nn)*(k_1+2*k_2+2*k_3+k_4)/6;
    end
    sec_con(:,nn) = y(:,2);
end
%
%% 2nd Order Adams-Moulton Method
% y_n+1 = y_n + dt/2 * (f(t_n+1,y_n+1)+f(t_n,y_n))

nn = length(N);
yfact_AM = zeros(6,N(nn)+1);
t = [0:N(nn)]*dt(nn);
yfact_AM(:,1) = [1;0.5;0.25;0;0;-1];
m_1 = inv(eye(6)+(dt(nn)/2)*inv(A)*B);
m_2 = (eye(6)-(dt(nn)/2)*inv(A)*B);
m_3 = (dt(nn)/2)*inv(A)*C;
for ii = 1 : N(nn)
    yfact_AM(:,ii+1) = m_1 * (m_2*yfact_AM(:,ii)-m_3*(sin(2*pi*t(:,ii))+sin(2*pi*t(:,ii+1))));
end

for nn = 1 : length(N)
    y = zeros(6,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    m_1 = inv(eye(6)+(dt(nn)/2)*inv(A)*B);
    m_2 = (eye(6)-(dt(nn)/2)*inv(A)*B);
    m_3 = (dt(nn)/2)*inv(A)*C;
    for ii = 1 : N(nn)
        y(:,ii+1) = m_1 * (m_2*y(:,ii)-m_3*(sin(2*pi*t(:,ii))+sin(2*pi*t(:,ii+1))));
    end
    error_AM(nn) = finderror(y(1,:),yfact_AM(1,:));   
end

figure(1);
loglog(dt,error_AM);
xlabel('step size');
ylabel('relative error');
title('Error of 2nd Order Adams-Moulton Method');
%
%% 2nd Order Backward Differetiation Formula
% y_n+1 = (4/3)*y_n - (1/3)*y_n-1 + (2/3)*dt*f(t_n+1,y_n+1)
nn = length(N);
yfact_BDF = zeros(6,N(nn)+1);
t = [0:N(nn)]*dt(nn);
yfact_BDF(:,1) = [1;0.5;0.25;0;0;-1];
yfact_BDF(:,2) = sec_con(:,nn);
m_1 = inv(eye(6)+(2/3)*inv(A)*B*dt(nn));
m_2 = (2/3)*inv(A)*C*dt(nn);
for ii = 2 : N(nn)
    yfact_BDF(:,ii+1) = m_1 * ((4/3)*yfact_BDF(:,ii)-(1/3)*yfact_BDF(:,ii-1)-m_2*sin(2*pi*t(:,ii+1)));
end

for nn = 1 : length(N)
    y = zeros(6,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    y(:,2) = sec_con(:,nn);
    m_1 = inv(eye(6)+(2/3)*inv(A)*B*dt(nn));
    m_2 = (2/3)*inv(A)*C*dt(nn);
    for ii = 2 : N(nn)
        y(:,ii+1) = m_1 * ((4/3)*y(:,ii)-(1/3)*y(:,ii-1)-m_2*sin(2*pi*t(:,ii+1)));
    end
    error_BDF(nn) = finderror(y(1,:),yfact_BDF(1,:));
end

figure(2);
loglog(dt,error_BDF);
xlabel('step size');
ylabel('relative error');
title('Error of 2nd Order Backward Differetiation Formula');
%
%% Beeman's Algorithm
f_xt = @(x,t) inv(m_a)*(sin(2*pi*t)*m_c-m_b*x);

nn = length(N);
xfact_BA = zeros(3,N(nn)+1);
vfact_BA = zeros(3,N(nn)+1);
afact_BA = zeros(3,N(nn)+1);
t = [0:N(nn)]*dt(nn);
xfact_BA(:,1) = [1;0.5;0.25];
xfact_BA(:,2) = sec_con(1:3,nn);
vfact_BA(:,1) = [0;0;1];
vfact_BA(:,2) = sec_con(4:6,nn);
for ii = 2 : N(nn)
    % predictor
    afact_BA(:,ii-1) = f_xt(xfact_BA(:,ii-1),t(:,ii-1));
    afact_BA(:,ii) = f_xt(xfact_BA(:,ii),t(:,ii));
    xfact_BA(:,ii+1) = xfact_BA(:,ii) + vfact_BA(:,ii)*dt(nn) + (1/6)*(4*afact_BA(:,ii)-afact_BA(:,ii-1))*(dt(nn)^2);
    % corrector
    afact_BA(:,ii+1) = f_xt(xfact_BA(:,ii+1),t(:,ii+1));
    xfact_BA(:,ii+1) = xfact_BA(:,ii) + vfact_BA(:,ii)*dt(nn) + (1/6)*(afact_BA(:,ii+1)+2*afact_BA(:,ii))*(dt(nn)^2);
    vfact_BA(:,ii+1) = (xfact_BA(:,ii+1)-xfact_BA(:,ii)+(1/6)*(2*afact_BA(:,ii+1)+afact_BA(:,ii))*(dt(nn)^2))/dt(nn);
end
    
for nn = 1 : length(N)
    x = zeros(3,N(nn)+1);
    v = zeros(3,N(nn)+1);
    a = zeros(3,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    x(:,1) = [1;0.5;0.25];
    x(:,2) = sec_con(1:3,nn);
    v(:,1) = [0;0;1];
    v(:,2) = sec_con(4:6,nn);
    for ii = 2 : N(nn)
        % predictor
        a(:,ii-1) = f_xt(x(:,ii-1),t(:,ii-1));
        a(:,ii) = f_xt(x(:,ii),t(:,ii));
        x(:,ii+1) = x(:,ii) + v(:,ii)*dt(nn) + (1/6)*(4*a(:,ii)-a(:,ii-1))*(dt(nn)^2);
        % corrector
        a(:,ii+1) = f_xt(x(:,ii+1),t(:,ii+1));
        x(:,ii+1) = x(:,ii) + v(:,ii)*dt(nn) + (1/6)*(a(:,ii+1)+2*a(:,ii))*(dt(nn)^2);
        v(:,ii+1) = (x(:,ii+1)-x(:,ii)+(1/6)*(2*a(:,ii+1)+a(:,ii))*(dt(nn)^2))/dt(nn);
    end
    error_Bee(nn) = finderror(x(1,:),xfact_BA(1,:));
end

figure(3);
loglog(dt,error_Bee);
xlabel('step size');
ylabel('relative error');
title('Error of Beemans Algorithm');
%