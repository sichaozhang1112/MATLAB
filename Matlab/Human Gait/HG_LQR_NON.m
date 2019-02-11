% Define conditions of ODE
dq_fun = @difeq_HG_FSF_NON;
tspan = 0:0.01:10;
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

% Place the Pole of Linear Quadratic Regulator
q = [800,400,200,0,0,0];
Q = diag(q,0);
R = [1,0,0;0,1,0;0,0,1];
K = lqr(A,B,Q,R);

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
title('Displacements of Nonlinear Human Gait with Linear Quadratic Regulator');
grid on;
grid minor;