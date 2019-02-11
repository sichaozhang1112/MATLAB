%% function
func = @(x) 1./(x);
%
%% 1
xval = 1;
fact = 2*xval^(-3);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'r','linewidth',1.5);
hold on;
%
%% 0.1
xval = 0.1;
fact = 2*xval^(-3);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'b','linewidth',1.5);
hold on;
%
%% 0.01
xval = 0.01;
fact = 2*xval^(-3);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'k','linewidth',1.5);
hold on;
%
%%
legend('x=1','x=0.1','x=0.01');
xlabel('Step Size');
ylabel('Error');
title('Error of 8th central difference with Variable Step Size (1/x)');
%


