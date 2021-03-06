dq_fun = @difeq_IPS;
tspan = [0:0.01:5];
y0 = [1;0;pi/3;0];
m = 0.1;
M = 2;
l = 0.5;
g = 9.8;
P = [-3+1i,-3-1i,-2+3j,-2-3j];
A = [0,1,0,0;
    0,0,-m*g/M,0;
    0,0,0,1;
    0,0,(m+M)*g/(M*l),0];
B = [0;1/M;0;-1/(M*l)];
K = place(A,B,P);
[t,y] = ode45(dq_fun,tspan,y0,[],K,A,B);
plot(t,y(:,1),'-r','linewidth',2);
hold on;
plot(t,y(:,2),'-y','linewidth',2);
hold on;
plot(t,y(:,3),'-g','linewidth',2);
hold on;
plot(t,y(:,4),'-b','linewidth',2);
hold on;
legend('x','xdot','theta','thetadot');
xlabel('Time');
ylabel('Displacement');
title('Displacements of Linearized Inverted Pendulum System with Full State Feedback Control');
grid on;
grid minor;





