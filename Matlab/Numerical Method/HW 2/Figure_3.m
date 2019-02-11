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
nn = length(N);
t = [0:N(nn)]*dt(nn);
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
y = zeros(6,N(nn)+1);
y(:,1) = [1;0.5;0.25;0;0;-1];
m_1 = inv(eye(6)+(dt(nn)/2)*inv(A)*B);
m_2 = (eye(6)-(dt(nn)/2)*inv(A)*B);
m_3 = (dt(nn)/2)*inv(A)*C;
for ii = 1 : N(nn)
    y(:,ii+1) = m_1 * (m_2*y(:,ii)-m_3*(sin(2*pi*t(:,ii))+sin(2*pi*t(:,ii+1))));
end

plot(t,y(1,:));
hold on;
%
%% 2nd Order BDF
% y_n+1 = (4/3)*y_n - (1/3)*y_n-1 + (2/3)*dt*f(t_n+1,y_n+1)
y = zeros(6,N(nn)+1);
t = [0:N(nn)]*dt(nn);
y(:,1) = [1;0.5;0.25;0;0;-1];
y(:,2) = sec_con(:,nn);
m_1 = inv(eye(6)+(2/3)*inv(A)*B*dt(nn));
m_2 = (2/3)*inv(A)*C*dt(nn);
for ii = 2 : N(nn)
    y(:,ii+1) = m_1 * ((4/3)*y(:,ii)-(1/3)*y(:,ii-1)-m_2*sin(2*pi*t(:,ii+1)));
end

plot(t,y(1,:));
hold on;
%
%% Beeman's Algorithm
f_xt = @(x,t) inv(m_a)*(sin(2*pi*t)*m_c-m_b*x);
    
x = zeros(3,N(nn)+1);
v = zeros(3,N(nn)+1);
a = zeros(3,N(nn)+1);
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


plot(t,x(1,:));
hold on;
%
%%
xlabel('t');
ylabel('x');
title('Solution of x: AD2, BDF2 and Beeman');
legend('AD2','BDF2','Beeman');