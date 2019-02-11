%% function
func = @(x) 3*sin(2*x)+1e6;
%
%% 1
xval = 0;
fact = -12*sin(2*xval);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'r','linewidth',1.5);
hold on;
%
%% 0.1
xval = 0.7;
fact = -12*sin(2*xval);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'b','linewidth',1.5);
hold on;
%
%% 0.01
xval = 1.57;
fact = -12*sin(2*xval);
est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
error = abs(fact - est);
loglog(h,error,'k','linewidth',1.5);
hold on;
%
%%
legend('x=1','x=10','x=100');
xlabel('Step Size');
ylabel('Error');
title('Error of 8th central difference with Variable Step Size (1e8*x^3)');
%