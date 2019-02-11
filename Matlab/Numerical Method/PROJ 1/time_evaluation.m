%
%% MECH 505 - Project 1
%% Sichao Zhang
%
%% function definition

func = @(x) tan(x);
xval = pi/4;
fact = 2*(1+tan(xval)^2)*tan(xval);
% func = @(x) 3*sin(2*x);
% xval = 1.57;
% fact = -12*sin(2*xval);
h = logspace(-6,-1,1000);

%
%% central 2nd

for hh = 1 : 1000
    tic
    for cntr = 1 : 1000
        est = (func(xval-h(hh)) - 2*func(xval) + func(xval+h(hh)))./(h(hh).^2);
    end
    time(hh) = toc/1000;
end

loglog(h,time,'r','linewidth',1.5);
hold on;

%
%% central 4th

for hh = 1 : 1000
    tic
    for cntr = 1 : 1000
        est = ((-1/12)*func(xval-2*h) + (4/3)*func(xval-h) + (-5/2)*func(xval) + (4/3)*func(xval+h) + (-1/12)*func(xval+2*h)) ./ (h.^2);  
    end
    time(hh) = toc/1000;
end

loglog(h,time,'b','linewidth',1.5);
hold on;

%
%% central 6th

for hh = 1 : 1000
    tic
    for cntr = 1 : 1000
        est = ((1/90)*func(xval-3*h) + (-3/20)*func(xval-2*h) + (3/2)*func(xval-h) + (-49/18)*func(xval) + (3/2)*func(xval+h) + (-3/20)*func(xval+2*h) + (1/90)*func(xval+3*h)) ./ (h.^2);
    end
    time(hh) = toc/1000;
end

loglog(h,time,'g','linewidth',1.5);
hold on;

%
%% central 8th

for hh = 1 : 1000
    tic
    for cntr = 1 : 1000
        est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
    end
    time(hh) = toc/1000;
end

loglog(h,time,'k','linewidth',1.5);
hold on;

%
%%
legend('central 2nd','central 4th','central 6th','central 8th');
xlabel('Step Size');
ylabel('Time');
title('Time of Finite Differences with Variable Step Size (tan(x),x=pi/4)');
%
