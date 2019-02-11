%% a forward difference scheme with first order accuracy
h = logspace(-6,-2,1000);
x = 1.57;
ydot = 1 ./ (cos(x) .^ 2);
ydot_est = (tan(x+h) - tan(x)) ./ h;
error = abs(ydot - ydot_est);
loglog(h,error,'r','linewidth',1.5);
grid minor;
hold on;

%
%% a forward difference scheme with third order accuracy
h = logspace(-6,-2,1000);
x = 1.57;
ydot = 1 ./ (cos(x) .^ 2);
ydot_est = ((-11/6) * tan(x) + 3 * tan(x+h) + (-3/2) * tan(x+2*h) + (1/3) * tan(x+3*h)) ./ h;
error = abs(ydot - ydot_est);
loglog(h,error,'b','linewidth',1.5);
hold on;

%
%% a central difference scheme with second order accuracy
h = logspace(-6,-2,1000);
x = 1.57;
ydot = 1 ./ (cos(x) .^ 2);
ydot_est = ((-1/2)*tan(x-h) + (1/2)*tan(x+h)) ./ h;
error = abs(ydot - ydot_est);
loglog(h,error,'g','linewidth',1.5);
hold on;

%
%% a central difference scheme with sixth order accuracy
h = logspace(-6,-2,1000);
x = 1.57;
ydot = 1 ./ (cos(x) .^ 2);
ydot_est = ((-1/60)*tan(x-3*h) + (3/20)*tan(x-2*h)+(-3/4)*tan(x-h) + (3/4)*tan(x+h) + (-3/20)*tan(x+2*h) + (1/60)*tan(x+3*h)) ./ h;
error = abs(ydot - ydot_est);
loglog(h,error,'c','linewidth',1.5);
hold on;

%
%% a complex step approximation
h = logspace(-6,-2,1000);
x = 1.57;
ydot = 1 ./ (cos(x) .^ 2);
ydot_est = imag(tan(x+i*h))./h;
error = abs(ydot - ydot_est);
loglog(h,error,'k','linewidth',1.5);
hold on;

%
%%
legend('forward,first','forward,third','central,second','central,sixth','complex step');
xlabel('Step Size');
ylabel('Error');
title('Error of First Derivative of tan(x) with Numerical Solution');