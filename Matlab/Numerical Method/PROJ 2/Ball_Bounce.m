%% Ball Bounce Problem

%% conditions
SysMat = [0 0; 1 0] ;
v0 = -5; x0 = 10 ;
ICs = [v0; x0] ; %#ok<NASGU> % q = [ydot,y];
trange = [0, 10] ;
force = @(t,y) ballfunc(t,y); %#ok<NASGU>

%% evaluation and plot
tic
[true_t,true_y] = ballbounce(x0,v0,trange(2));
toc
[true_t,true_y] = end_modification(trange(2),true_t,true_y);
true_area = trapezoid(true_t,true_y);

%%
h = 1e-6 : 1e-6 : 1e-4;
for ii = 1 : length(h)
[dp_t,dp_y] = Dormand_Prince(force,SysMat,trange,ICs,h(ii));
[dp_t,dp_y] = end_modification(trange(2),dp_t,dp_y);
dp_area = trapezoid(dp_t,dp_y);
dp_error(ii) = abs(true_area - dp_area);
[rkf_t,rkf_y] = RK_Fehlberg(force,SysMat,trange,ICs,h(ii));
[rkf_t,rkf_y] = end_modification(trange(2),rkf_t,rkf_y);
rkf_area = trapezoid(rkf_t,rkf_y);
rkf_error(ii) = abs(true_area - rkf_area);
[ck_t,ck_y] = Cash_Karp(force,SysMat,trange,ICs,h(ii));
[ck_t,ck_y] = end_modification(trange(2),ck_t,ck_y);
ck_area = trapezoid(ck_t,ck_y);
ck_error(ii) = abs(true_area - ck_area);
end
%%
loglog(h,dp_error);
hold on;
loglog(h,rkf_error);
hold on;
loglog(h,ck_error);
hold on;
%%
legend('Dormand-Prince','Fehlberg','Cash-Karp');
xlabel('time step');
ylabel('error');
title('Compare of Three Embedded Runge Kutta Methods(Ball Bounce)');
%%
% tic
% [dp_t,dp_y] = Dormand_Prince(force,SysMat,trange,ICs);
% toc
% 
% tic
% [rkf_t,rkf_y] = RK_Fehlberg(force,SysMat,trange,ICs);
% toc
% 
% tic
% [ck_t,ck_y] = Cash_Karp(force,SysMat,trange,ICs);
% toc

% plot(true_t,true_y);
% hold on;
% plot(dp_t,dp_y(:,2));
% hold on;
% plot(rkf_t,rkf_y(:,2));
% hold on;
% plot(ck_t,ck_y(:,2));
% hold on;

% legend('fact','Dormand-Prince','Fehlberg','Cash-Karp');
% xlabel('time');
% ylabel('displacement');
% title('Compare of Three Embedded Runge Kutta Methods(Ball Bounce, h=1e-5)');
%%
% title('RK4 with Different Time Steps (Ball Bounce)');
% xlabel('time');
% ylabel('displacement');
% xmin = 0;
% xmax = 10;
% ymin = 0;
% ymax = 20;
% axis([xmin xmax ymin ymax]);
% legend('fact','h = 1e-3','h = 1e-4','h = 1e-5')

%%
% tic
% [AM2_t,AM2_y] = AM2(force, SysMat, trange, ICs);
% t3 = toc;
% 
% plot(AM2_t,AM2_y(2,:));
% hold on;
% 
% tic
% [Bee_t,Bee_y] = Beeman(force, SysMat, trange, ICs);
% t4 = toc;
% 
% plot(Bee_t,Bee_y(2,:));
% hold on;
% %
% title('Compare of Three Methods (sample code,K=1,M=1)');
% xlabel('time');
% ylabel('displacement');
% xmin = 0;
% xmax = 10;
% ymin = 0;
% ymax = 20;
% axis([xmin xmax ymin ymax]);
% legend('fact','RK4','AM2','Beeman')
%% function definition
function force = ballfunc(~,y)
% constants
g = 9.81 ;
k = 1e6 ;
m = 0.01 ; %i.e. a ball bearing
w = sqrt(k/m) ;
zeta = 0.05 ;

if y(2) >= 0
  force = [-g; 0];
else
  force = [-2*zeta*w*y(1)-w^2*y(2)-g;0] ;
end
end

function [t,d] = ballbounce(x0,v0,T)

% constants
g = 9.81 ;
k = 1e6 ;
m = 0.01 ; %i.e. a ball bearing
w = sqrt(k/m) ;
zeta = 0.05 ;
wd = sqrt(1-zeta^2)*w ;

t0 = 0;
t_next = findImpact(t0,x0,v0) ;
X0 = x0; V0 = v0;
t = t0;
d = X0;
v = V0;

% T = trange(2)
while t_next < T
  % Free flight:
  ts = linspace(t0,t_next,1001) ;
  t = [t ts(2:end)]; %#ok<*AGROW>
  d = [d (-1/2*g*(ts(2:end)-t0).^2+V0*(ts(2:end)-t0)+X0)] ;
  v = [v -g*(ts(2:end)-t0)+V0];
  X0 = (-1/2*g*(t_next-t0)^2+V0*(t_next-t0)+X0) ;   %#ok<NASGU>
  V0 = (-g*(t_next-t0)+V0) ;
  % Rebound:
  t0 = t_next ;
  t_free = findFree(t0,V0,m,k,zeta) ;
  ts = linspace(t0,t_free,101) ;
  t = [t ts(2:end)] ;
  A = m*g/k-sqrt(-1)*(zeta*w*(m*g/k)+V0)/wd ;
  d = [d real(A*exp((-zeta*w+sqrt(-1)*wd)*(ts(2:end)-t0))-m*g/k)] ; 
  v = [v real(A*(-zeta*w+sqrt(-1)*wd)*exp((-zeta*w+sqrt(-1)*wd)*(ts(2:end)-t0)));];
  X0 = real(A*exp((-zeta*w+sqrt(-1)*wd)*(t_free-t0))-m*g/k);  
  V0 = real(A*(-zeta*w+sqrt(-1)*wd)*exp((-zeta*w+sqrt(-1)*wd)*(t_free-t0)));
  t0 = t_free ;
  t_next = findImpact(t0,X0,V0) ;
end
% Free flight:
ts = linspace(t0,t_next,1001) ;
t = [t ts(2:end)];
d = [d (-1/2*g*(ts(2:end)-t0).^2+V0*(ts(2:end)-t0)+X0)] ;
v = [v -g*(ts(2:end)-t0)+V0];
end

function t_free = findFree(t0,V0,m,k,zeta)
g = 9.81 ;
w = sqrt(k/m) ;
wd = sqrt(1-zeta^2)*w ;
% A = m*g/k-sqrt(-1)*(zeta*w*(m*g/k)+V0)/wd ;
% phi = atan2(imag(A),real(A)) ;
% t_next = t0+(2*pi-2*phi)/wd ;
% t_next = t0+real(log(m*g/k/A)/(sqrt(-1)*wd-zeta*w)) ;
% if t_next < t0
%   t_next = t0+real((log(m*g/k/A)+2*pi*sqrt(-1))/(sqrt(-1)*wd-zeta*w)) ;
% end
options = optimset('Display','off','TolX',eps,'TolFun',eps);
t_free = fzero(@(t) real((g/w^2-sqrt(-1)*(g/w*zeta+V0)/sqrt(1-zeta^2)/w)*exp((-zeta*w+sqrt(-1)*w*sqrt(1-zeta^2))*(t-t0))-m*g/k), ...
  [t0+pi/wd,t0+3*pi/2/wd],options) ;
end

function t_next = findImpact(t0,X0,V0)
g = 9.81 ;
t_next = (t0+V0/g)+sqrt(V0^2/g^2+2*X0/g) ;
end
