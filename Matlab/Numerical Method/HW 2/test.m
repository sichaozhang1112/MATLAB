%% Function Definition
Ifact = @(t) cos(10*t);
period_fact = pi/10;
diss_fact1 = zeros(2,24);
diss_fact1(1,:) = ones(1,24);
diss_fact1(2,:) = [0:23]*2*pi/10;
diss_fact2 = zeros(2,24);
diss_fact2(1,:) = -ones(1,24);
diss_fact2(2,:) = pi/10+[0:23]*2*pi/10;
N = 1e4 : 1e4 : 1e5;
dt = 15./N;
A = [100,0;0,1];
B = [0,1;-1,0];
getk = @(y) -inv(B)*A*y;
%
%%
nn = 1;
y = zeros(2,N(nn)+1);
y(1,1) = 1;
y(2,1) = 0;
for ii  = 1 : N(nn)
    y(:,ii+1) =  inv(eye(2)+dt(nn)*inv(B)*A)*y(:,ii);
end   
t = [0:N(nn)]*dt(nn);
%
%%
erks = y(1,:);
dt = dt(nn);
for ii = 2 : length(erks)-1
    if erks(ii)>=erks(ii+1) && erks(ii)>=erks(ii-1)
        func_peak1(1,ii) = erks(ii);
        func_peak1(2,ii) = ii*dt;
    end
end

for ii = 2 : length(erks)-1
    if erks(ii)<=erks(ii+1) && erks(ii)<=erks(ii-1)
        func_peak2(1,ii) = erks(ii);
        func_peak2(2,ii) = ii*dt;
    end
end

func_peak1(func_peak1==0)=[];
func_peak2(func_peak2==0)=[];

func_peak1 = reshape(func_peak1,2,[]);
func_peak2 = reshape(func_peak2,2,[]);

if length(func_peak1) == 24
    func_peaks(1:2,:) = func_peak1;
else func_peaks(1:2,2:24) = func_peak1;
    func_peaks(1:2,1) = [1,0];
end

func_peaks(3:4,:) = func_peak2;
%% IMEX
% for nn = 1 : length(N)
nn = 10;
    y = zeros(6,N(nn)+1);
    ystar = zeros(6,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    for ii = 1 : N(nn)
        ystar(:,ii+1) = y(:,ii) + dt(nn) * inv(A)*C*sin(2*pi*t(ii));
        y(:,ii+1) = inv(eye(6)+dt(nn)*inv(A)*B) * ystar(:,ii+1);
    end    
% end
figure(1);
plot(t,y(1,:));
hold on;
figure(2);
plot(t,y(2,:));
hold on;
figure(3);
plot(t,y(3,:));
hold on;
%
%% Implicit
% for nn = 1 : length(N)
nn = 10;
    y = zeros(6,N(nn)+1);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    for ii = 1 : N(nn)
        y(:,ii+1) = inv(eye(6)+dt(nn)*inv(A)*B) * (y(:,ii)+dt(nn)*inv(A)*C*sin(2*pi*t(ii+1)));
    end    
% end
figure(1);
plot(t,y(1,:));
hold on;
figure(2);
plot(t,y(2,:));
hold on;
figure(3);
plot(t,y(3,:));
hold on;
%
%% RK2
% for nn = 1 : length(N)
nn = 10;
    y = zeros(6,N(nn)+1);
    ydot = zeros(6,N(nn)+1);
    t = [0:N(nn)]*dt(nn);
    y(:,1) = [1;0.5;0.25;0;0;-1];
    for ii = 1 : N(nn)
        ydot(:,ii) = getk(y(:,ii),t(ii));
        y(:,ii+1) = y(:,ii) + dt(nn)*getk(y(:,ii)+0.5*dt(nn)*ydot(:,ii),t(ii)+0.5*dt(nn));
    end    
% end
figure(1);
plot(t,y(1,:));
hold on;
figure(2);
plot(t,y(2,:));
hold on;
figure(3);
plot(t,y(3,:));
hold on;
%
% %% Crank-Nicolson
% % for nn = 1 : length(N)
% nn = 10;
%     y = zeros(6,N(nn)+1);
%     t = [0:N(nn)]*dt(nn);
%     y(:,1) = [1;0.5;0.25;0;0;-1];
%     for ii = 1 : N(nn)
%         y(:,ii+1) = inv(1+0.5*dt(nn)*inv(A)*B) * ((1-0.5*dt(nn)*inv(A)*B)*y(:,ii)+0.5*dt(nn)*(inv(A)*C*sin(2*pi*t(ii))+inv(A)*C*sin(2*pi*t(ii+1))));
%     end    
% % end
% figure(1);
% plot(t,y(1,:));
% hold on;
% figure(2);
% plot(t,y(2,:));
% hold on;
% figure(3);
% plot(t,y(3,:));
% hold on;
% %
%% A Second Order Explicit Runge Kutta Scheme
for nn = 1 : length(N)
    y = zeros(2,N(nn)+1);
    ydot = zeros(2,N(nn)+1);
    y(1,1) = 1;
    y(2,1) = 0;
    for ii  = 1 : N(nn)
        ydot(:,ii) = getk(y(:,ii));
        y(:,ii+1) = y(:,ii) + dt(nn)*getk(y(:,ii)+0.5*dt(nn)*ydot(:,ii));
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
hold on;
figure(2);
loglog(dt,diss_error);
hold on;
%

