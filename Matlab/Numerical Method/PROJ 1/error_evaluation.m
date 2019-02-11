%
%% MECH 505 - Project 1
%% Sichao Zhang
%
%% function definition

func = @(x) tan(x);
xval = 1.57;
fact = 2*(1+tan(xval)^2)*tan(xval);

% func = @(x) 1./(x.^2);
% xval = 0.001;
% fact = 6*xval^(-4);

% func = @(x) 1e2*x.^3;
% xval = 10;
% fact = 6*1e2*xval;

% func = @(x) 3*sin(2*x)+1e6;
% xval = 1;
% fact = -12*sin(2*xval);

% func = @(x) x.^2;
% xval = 0;
% fact = 2;

h = logspace(-6,-1,1000);

%
%% central 2nd

est = (func(xval-h) - 2*func(xval) + func(xval+h))./(h.^2);
error = abs(fact - est);
loglog(h,error,'r','linewidth',1.5);
hold on;

%
%% central 4th

est = ((-1/12)*func(xval-2*h) + (4/3)*func(xval-h) + (-5/2)*func(xval) + (4/3)*func(xval+h) + (-1/12)*func(xval+2*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'b','linewidth',1.5);
hold on;

%
%% central 6th

est = ((1/90)*func(xval-3*h) + (-3/20)*func(xval-2*h) + (3/2)*func(xval-h) + (-49/18)*func(xval) + (3/2)*func(xval+h) + (-3/20)*func(xval+2*h) + (1/90)*func(xval+3*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'g','linewidth',1.5);
hold on;

%
%% central 8th

est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'k','linewidth',1.5);
hold on;

%
%%

legend('central 2nd','central 4th','central 6th','central 8th');
xlabel('Step Size');
ylabel('Error');
title('Error of Finite Differences with Variable Step Size (tan(x),x=1.57)');

%



