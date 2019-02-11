%
%% MECH 505 - Project 2
%% Sichao Zhang
%
%% Sample Code for Function Evaluation
K = 5;
M = 1;
t0 = 0;
t1 = 100;
trange = [t0,t1];

Stiff = K * [1,-1,0,0,0;
             -1,2,-1,0,0;
             0,-1,2,-1,0;
             0,0,-1,2,-1;
             0,0,0,-1,2];
Mass = M * eye(5);

A = [Mass,zeros(5);zeros(5),eye(5)]\[zeros(5),-Stiff;eye(5),zeros(5)];

ICd = [1;0;0;0;0];
ICv = zeros(5,1);
IC = [ICv;ICd];

func = @(t,y) [Mass,zeros(5);zeros(5),eye(5)]\(sin(t)*[1;0;0;0;0;0;0;0;0;0]);

%% solution using ode45
tic
[true_t,true_y] = int_fact(func, A, trange, IC);
toc

true_int = trapezoid(true_t,true_y);

%%
h = 1e-6 : 1e-6 : 1e-4;
for ii = 1 : length(h)
    tic
    [rkf_t,rkf_y] = RK_Fehlberg(func, A, trange, IC, h(ii));
    time(ii) = toc;
    [rkf_t,rkf_y] = end_modification(t1,rkf_t,rkf_y);
    rkf_int = trapezoid(rkf_t,rkf_y);
    error(ii) = abs(true_int-rkf_int);
end

%%
figure(1);
loglog(h,time);
hold on;
figure(2);
loglog(h,error);
hold on;

%%
figure(1);
legend('K=1,M=1','K=1,M=5','K=5,M=1');
xlabel('time step');
ylabel('time');
title('Evaluate the Time of RK-Fehlberg with Different Stiff and Mass');

figure(2);
legend('K=1,M=1','K=1,M=5','K=5,M=1');
xlabel('time step');
ylabel('error');
title('Evaluate the Error of RK-Fehlberg with Different Stiff and Mass');
%%
function [time,displacements] = int_fact(func,A,trange,IC)
options = odeset('RelTol',1e-9,'AbsTol',1e-9,'MaxStep',2e-3);
sysfunc = @(t,y) A*y+func(t,y);
[time,displacements] = ode45(sysfunc,trange,IC,options);
end
