%
%% MECH 505 - Homework 2
%% Sichao Zhang, S01276479
%
%% Problem 2
%% Function Definition
I = @(t) cos(10*t);
N = 1e4 : 1e4 : 1e5;
dt = 15./N;
A = [100,0;0,1];
B = [0,1;-1,0];
getk = @(y) -inv(B)*A*y;
nn = length(N);
t = dt(nn)*[0:N(nn)];
plot(t,I(t));
hold on;
%
%% A First Order Explicit Runge Kutta Scheme
y = zeros(2,N(nn)+1);
ydot = zeros(2,N(nn)+1);
y(1,1) = 1;
y(2,1) = 0;
for ii  = 1 : N(nn)
    ydot(:,ii) = getk(y(:,ii));
    y(:,ii+1) = y(:,ii) + dt(nn)*ydot(:,ii);
end   

plot(t,y(1,:));
hold on;
%
%% A First Order Implicit Scheme
y = zeros(2,N(nn)+1);
y(1,1) = 1;
y(2,1) = 0;
for ii  = 1 : N(nn)
    y(:,ii+1) =  inv(eye(2)+dt(nn)*inv(B)*A)*y(:,ii);
end 

plot(t,y(1,:));
hold on;
%
%%
xlabel('t');
ylabel('x');
title('Solution of x: Anlytical, 1st Order RK and 1st Order Implicit Method');
legend('analytical','1st order RK','1st order implicit');
