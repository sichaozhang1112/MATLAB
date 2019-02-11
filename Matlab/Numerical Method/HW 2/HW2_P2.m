%
%% MECH 505 - Homework 2
%% Sichao Zhang, S01276479
%
%% Problem 2
%% Function Definition
Ifact = @(t) cos(10*t);
period_fact = pi/10;
diss_fact1 = zeros(2,24);
diss_fact1(1,:) = ones(1,24);
diss_fact1(2,:) = [0:23]*2*pi/10;
diss_fact2 = zeros(2,24);
diss_fact2(1,:) = -ones(1,24);
diss_fact2(2,:) = pi/10+[0:23]*2*pi/10;
N = 1e3 : 1e3 : 1e5;
dt = 15./N;
A = [100,0;0,1];
B = [0,1;-1,0];
getk = @(y) -inv(B)*A*y;
%
%% A First Order Explicit Runge Kutta Scheme
for nn = 1 : length(N)
    y = zeros(2,N(nn)+1);
    ydot = zeros(2,N(nn)+1);
    y(1,1) = 1;
    y(2,1) = 0;
    for ii  = 1 : N(nn)
        ydot(:,ii) = getk(y(:,ii));
        y(:,ii+1) = y(:,ii) + dt(nn)*ydot(:,ii);
    end   
    t = [0:N(nn)]*dt(nn);
    period_est = diff(findzeros(y(1,:),dt(nn)));
    period_error(nn) = norm(period_fact-period_est);
    diss_est = findpeaks(y(1,:),dt(nn));
    dis_err1 = diss_fact1-diss_est(1:2,:);
    dis_err(1,:) = sqrt(dis_err1(1,:).^2+dis_err1(2,:).^2);
    dis_err2 = diss_fact2-diss_est(3:4,:);
    dis_err(2,:) = sqrt(dis_err2(1,:).^2+dis_err2(2,:).^2);
    diss_error(nn) = norm(reshape(dis_err,1,[]));
end

figure(1);
loglog(dt,period_error);
xlabel('step size');
ylabel('L2 norm error');
title('Period Error of A First Order Explicit Runge Kutta Scheme');
figure(2);
loglog(dt,diss_error);
xlabel('step size');
ylabel('L2 norm error');
title('Dissipation Error of A First Order Explicit Runge Kutta Scheme');
hold on;
%
%% A First Order Implicit Scheme
for nn = 1 : length(N)
    y = zeros(2,N(nn)+1);
    y(1,1) = 1;
    y(2,1) = 0;
    for ii  = 1 : N(nn)
        y(:,ii+1) =  inv(eye(2)+dt(nn)*inv(B)*A)*y(:,ii);
    end   
    t = [0:N(nn)]*dt(nn);
    period_est = diff(findzeros(y(1,:),dt(nn)));
    period_error(nn) = norm(period_fact-period_est);
    diss_est = findpeaks(y(1,:),dt(nn));
    dis_err1 = diss_fact1-diss_est(1:2,:);
    dis_err(1,:) = sqrt(dis_err1(1,:).^2+dis_err1(2,:).^2);
    dis_err2 = diss_fact2-diss_est(3:4,:);
    dis_err(2,:) = sqrt(dis_err2(1,:).^2+dis_err2(2,:).^2);
    diss_error(nn) = norm(reshape(dis_err,1,[]));
end

figure(3);
loglog(dt,period_error);
xlabel('step size');
ylabel('L2 norm error');
title('Period Error of A First Order Implicit Scheme');
figure(4);
loglog(dt,diss_error);
xlabel('step size');
ylabel('L2 norm error');
title('Dissipation Error of A First Order Implicit Scheme');
%
