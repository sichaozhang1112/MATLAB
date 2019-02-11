dq_fun = @difeq_twolink_simplegravitycompensation;
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
Kp_diag = [40,25];
Kv_diag = [30,40];
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

% x_T = x';
% x_tilde = [q_1d - x_T(1,:);0 - x_T(2,:);q_2d - x_T(3,:);0 - x_T(4,:)];
% 
% % Plot
% plot(t,x_tilde(1,:),'-r','linewidth',2);
% hold on;
% plot(t,x_tilde(2,:),'-y','linewidth',2);
% hold on;
% plot(t,x_tilde(3,:),'-g','linewidth',2);
% hold on;
% plot(t,x_tilde(4,:),'-b','linewidth',2);
% hold on;
% legend('q_1tilde','q_1tildedot','q_2tilde','q_2tildedot');
% xlabel('Time');
% ylabel('Displacement Error');
% title('Displacement Error of Two-Link Manipulator with PD Control-Simple Gravity Compensation');
% grid on;
% grid minor;