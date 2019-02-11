dq_fun = @difeq_humangait_simplified;
tspan = 0:0.01:10;
x0 = [0;0;0;0];

% The Parameters of Human Leg
% Link 1
m_1 = 5.7;
l_1 = 0.32;
l_c1 = 0.14;
I_1 = 0.061;
% Link 2
m_2 = 2.65;
l_2 = 0.40;
l_c2 = 0.17;
I_2 = 0.038;

g = 9.81;

Kp = [10,0;0,15];
Kv = [0,0;0,0];

[t,x] = ode45(dq_fun,tspan,x0,[],m_1,l_1,l_c1,I_1,m_2,l_2,l_c2,I_2,g,Kp,Kv);

plot(t,x(:,1));
hold on;
plot(t,x(:,2));
hold on;
plot(t,x(:,3));
hold on;
plot(t,x(:,4));
hold on;
grid on;
grid minor; 

