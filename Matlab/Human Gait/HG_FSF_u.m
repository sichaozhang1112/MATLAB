% Define conditions of ODE
dq_fun = @difeq_HG_FSF;
tspan = 0:0.01:1;
x0 = [-pi/10;-pi/6;-pi/8;0;0;0];

% A and B of Jacobian Linearization
A = [0,0,0,1,0,0;
     0,0,0,0,1,0;
     0,0,0,0,0,1;
     56.1252,25.8219,15.8727,0,0,0;
     -71.5516,74.9073,-13.0651,0,0,0;
     45.5660,-116.9023,77.5195,0,0,0;];
 B = [0,0,0;
      0,0,0;
      0,0,0;
      1.7164,2.1881,12.0348;
      -2.1881,6.3475,-9.9061;
      1.3934,-9.9061,58.7761];
  
% Place the Pole of Full State Feedback
P = [-15+1i,-15-1i,-9+1i,-9-1i,-10+1i,-10-1i];
K = place(A,B,P);

% Solve the ODE
[t,x] = ode45(dq_fun,tspan,x0,[],K,A,B);

u = - K * x';

% Plot result 
plot(t,u(1,:),'-g','linewidth',2);
hold on;
plot(t,u(2,:),'-b','linewidth',2);
hold on;
plot(t,u(3,:),'-c','linewidth',2);
hold on;
legend('u_1','u_2','u_3');
xlabel('Time');
ylabel('Torque');
title('Torques of Linearized Human Gait with Full State Feedback Control');
grid on;
grid minor;