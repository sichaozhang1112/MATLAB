% Double Support Case
% a = [a_11, a_12, a_13, 0, 0, 0, 0;
%      a_21, a_22, a_23, 0, 0, 0, 0;
%      a_31, a_32, a_33, 0, 0, 0, 0;
%      0, 0, 0 , a_44, a_45, a_46, a_47;
%      0, 0, 0 , a_54, a_55, a_56, a_57;
%      0, 0, 0 , a_64, a_65, a_66, a_67;
%      0, 0, 0 , a_74, a_75, a_76, a_77];
% b = [b_1;b_2;b_3;b_4;b_5;b_6;b_7];

% Anthropometric and Related constants
B = 0.140; % heel to ankle distance
C = 0.189; % heel to CG distance
A = 0.116; % ankle to CG distance
m_f = 1.159; % foot mass
I_f = 0.010; % foot moment of inertia about CG
alpha = 2.621; % angle between sole and ankle measured at the toe
beta = 0.967; % angle between sole and ankle measured at the heel
gamma = 0.310; % angle between sole and CG measured at the heel
D = 0.247; % ankle to shank CG distance
E = 0.188; % shank CG to knee distance
m_s = 3.717; % shank mass
I_s = 0.064; % shank moment of inertia about CG
F = 0.227; % knee to thigh CG distance
G = 0.173; % thigh CG to hip distance
m_t = 7.994; % thigh mass
I_t = 0.133; % thigh moment of inertia about CG
H = 0.325; % hip to CG of head, arms and trunk(HAT) distance
m_h = 54.2; % HAT mass
I_h = 3.591; % HAT moment of inertia about CG
W_m = 79.9; % total body mass
S_k = 274400; % spring constant at hip
f = 1000; % damping coefficient of damper in hip
g = 9.807; % gravational constat
S = 0.11; % initial left-toe to right-heel distance

dq_fun = @difeq_humangait;
tspan = [0: 0.002: 0.02];
x0 = [0;0;pi/2;0;pi/2;0;pi/2;0;pi/2;0;pi/2;0;0;0];

[t, x] = ode45(dq_fun, tspan, x0, [],B,C,A,m_f,I_f,alpha,beta,gamma,D,E,m_s,I_s,F,G,m_t,I_t,H,m_h,I_h,W_m,S_k,f,g,S);

plot(t,x(:,1),'-r','linewidth',2);
hold on;
plot(t,x(:,2),'-y','linewidth',2);
hold on;
plot(t,x(:,3),'-g','linewidth',2);
hold on;
plot(t,x(:,4),'-b','linewidth',2);
hold on;
% plot(t,x(:,5),'-r','linewidth',2);
% hold on;
% plot(t,x(:,6),'-y','linewidth',2);
% hold on;
% plot(t,x(:,7),'-g','linewidth',2);
% hold on;
% plot(t,x(:,8),'-b','linewidth',2);
% hold on;
% plot(t,x(:,9),'-g','linewidth',2);
% hold on;
% plot(t,x(:,10),'-b','linewidth',2);
% hold on;
% plot(t,x(:,11),'-r','linewidth',2);
% hold on;
% plot(t,x(:,12),'-y','linewidth',2);
% hold on;
% plot(t,x(:,13),'-g','linewidth',2);
% hold on;
% plot(t,x(:,14),'-b','linewidth',2);
% hold on;
grid on;
grid minor;





    
