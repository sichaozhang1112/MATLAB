% Define conditions of ODE
dq_fun = @difeq_HG_FSF_NON;
tspan = 0:0.01:3;
x0 = [-pi/10;-pi/6;-pi/8;0;0;0];

% Parameters
m_1 = 7.994;
l_1 = 0.4;
l_c1 = 0.173;
I_1 = 0.133;
m_2 = 3.717;
l_2 = 0.435;
l_c2 = 0.188;
I_2 = 0.064;
m_3 = 1.159;
l_c3 = 0.116;
I_3 = 0.010;
g = 9.81;

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
% P = [-10+2i,-10-2i,-20+3i,-20-3i,-10+1i,-10-1i];
P = [-15+1i,-15-1i,-9+1i,-9-1i,-10+1i,-10-1i];
K = place(A,B,P);

% Solve the ODE
[t,x] = ode45(dq_fun,tspan,x0,[],K,m_1,l_1,l_c1,I_1,m_2,l_2,l_c2,I_2,m_3,l_c3,I_3,g);

% Plot result 
plot(t,x(:,1),'-r','linewidth',2);
hold on;
plot(t,x(:,2),'-y','linewidth',2);
hold on;
plot(t,x(:,3),'-m','linewidth',2);
hold on;
plot(t,x(:,4),'-g','linewidth',2);
hold on;
plot(t,x(:,5),'-b','linewidth',2);
hold on;
plot(t,x(:,6),'-c','linewidth',2);
hold on;
legend('q_1','q_2','q_3','q_1dot','q_2dot','q_3dot');
xlabel('Time');
ylabel('Displacement');
title('Displacements of Nonlinear Human Gait with Full State Feedback Control');
grid on;
grid minor;
