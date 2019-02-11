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