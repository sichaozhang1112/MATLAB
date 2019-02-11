dq_fun = @difeq_twolink_nogravity;
tspan = [0:0.01:15];
x0 = [0;0;0;0];

% System Parameters
m_1 = 2;
I_1 = 3;
l_1 = 1.5;
l_c1 = 0.75;
m_2 = 1;
I_2 = 2;
l_2 = 1;
l_c2 = 0.5;
g = 9.81;

% Desired State
q_1d = pi/2;
q_2d = 3 * pi/2;

% PD Controller
Kp_diag = [110,110];
Kv_diag = [70,70];
Kp = diag(Kp_diag);
Kv = diag(Kv_diag);
  
% ODE
[t,x] = ode45(dq_fun,tspan,x0,[],m_1,m_2,I_1,I_2,l_1,l_2,l_c1,l_c2,g,q_1d,q_2d,Kp,Kv);

q_tilde = [(q_1d - x(:,1))';
           (q_2d - x(:,3))'];
q_tildedot = [(0 - x(:,2))';
              (0 - x(:,4))'];
u = Kp * q_tilde + Kv * q_tildedot;

%Plot
plot(t,u(1,:),'-g','linewidth',2);
hold on;
plot(t,u(2,:),'-b','linewidth',2);
hold on;
legend('u_1','u_2');
grid on;
grid minor;
