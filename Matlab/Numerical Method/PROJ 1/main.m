%
%% MECH 505 - Project 1
%% Sichao Zhang
%
%% Main 

func = @(x) tan(x);
xval = 1.57;
fact = 2*(1+tan(xval)^2)*tan(xval);
fprintf([num2str(fact) '\n'])

% func = @(x) 1./(x.^2);
% xval = 0.001;
% fact = 6*xval^(-4);
% fprintf([num2str(fact) '\n'])

% func = @(x) 1e2*x.^3;
% xval = 10;
% fact = 6*1e2*xval;

% func = @(x) 3*sin(2*x)+1e6;
% xval = 1;
% fact = -12*sin(2*xval);
% fprintf([num2str(fact) '\n'])

% func = @(x) x.^2;
% xval = 0;
% fact = 2;
% fprintf([num2str(fact) '\n'])

tic
for cntr = 1 : 1000000
    d2f = func_112(func,xval);
end

time = toc/1000000;
error = abs(d2f - fact);

fprintf(['Average Time: ' num2str(time) ' seconds.\n'])
fprintf(['Error of last calculation: ' num2str(error*100) ' %%.\n\n'])

%
%% central difference
% % 2nd order accuracy
% d2f = (func(x-h) - 2*func(x) +func(x+h))/(h^2);
% % 4th order accuracy
% d2f = ((-1/12)*func(x-2*h) + (4/3)*func(x-h) + (-5/2)*func(x) + (4/3)*func(x+h) + (-1/12)*func(x+2*h)) / (h^2);
% % 6th order accuracy

% d2f = ((1/90)*func(x-3*h) + (-3/20)*func(x-2*h) + (3/2)*func(x-h) + (-49/18)*func(x) + (3/2)*func(x+h) + (-3/20)*func(x+2*h) + (1/90)*func(x+3*h)) / (h^2);
% % 8th order accuracy
% d2f = ((-1/560)*func(x-4*h) + (8/315)*func(x-3*h) + (-1/5)*func(x-2*h) + (8/5)*func(x-h) + (-205/72)*func(x) + (8/5)*func(x+h) + (-1/5)*func(x+2*h) + (8/315)*func(x+3*h) + (-1/560)*func(x+4*h)) / (h^2);


