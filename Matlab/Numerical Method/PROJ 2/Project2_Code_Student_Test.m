clear all %#ok<CLALL>
close all
clc

Participants = 20 ; % Your function number.
Names = {'Test'} ;
year = '1' ;

times = zeros(length(Participants),3) ;
errors = times ;
scores = zeros(length(Participants),2,4) ;
ranks = zeros(length(Participants),2,4) ;


%% Challenge 3: Ball Bouncing on a Surface %%

fprintf('Challenge 3: Ball Bouncing on a Surface\n')

SysMat = [0 0; 1 0] ;
v0 = -5; x0 = 10 ;
% q = [ydot,y];
ICs = [v0; x0] ; %#ok<NASGU>
trange = [0, 10] ;
force = @(t,y) ballfunc(t,y); %#ok<NASGU>
[true_t,true_d] = ballbounce(x0,v0,trange(2)) ;

fprintf('Commencing simulations\n')
for cnt = 1:length(Participants)
  fstring = ['int_112'] ;
  fprintf(['' fstring ':\n'])
  %Assess computational time and accuracy
  tic
  eval(['[t,d] = ' fstring '(force,SysMat,trange,ICs);'])
  times(cnt,3) = toc ;
  if size(d,1) == length(SysMat)
    d = d';
    t = t';
  end
  error = (d(:,2)-interp1(true_t',true_d',t)) ;
  errors(cnt,3) = norm(error(2:end).*diff(t)) ;
  if errors(cnt,3) == Inf || isnan(errors(cnt,3))
    errors(cnt,3) = 1e10 ;
  end
  fprintf(['Time for ' fstring ' is ' num2str(times(cnt,3)) ' seconds.\n'])
  fprintf(['Error for ' fstring ' is ' num2str(errors(cnt,3)*100) '%%.\n\n'])
end

clear cnt cntr d error force fstring ICs SysMat t trange true_d true_t v0 x0



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

while t_next < T
  % Free flight:
  ts = linspace(t0,t_next,1001) ;
  t = [t ts(2:end)]; %#ok<*AGROW>
  d = [d (-1/2*g*(ts(2:end)-t0).^2+V0*(ts(2:end)-t0)+X0)] ;
  X0 = (-1/2*g*(t_next-t0)^2+V0*(t_next-t0)+X0) ;   %#ok<NASGU>
  V0 = (-g*(t_next-t0)+V0) ;
  % Rebound:
  t0 = t_next ;
  t_free = findFree(t0,V0,m,k,zeta) ;
  ts = linspace(t0,t_free,101) ;
  t = [t ts(2:end)] ;
  A = m*g/k-sqrt(-1)*(zeta*w*(m*g/k)+V0)/wd ;
  d = [d real(A*exp((-zeta*w+sqrt(-1)*wd)*(ts(2:end)-t0))-m*g/k)] ; 
  X0 = real(A*exp((-zeta*w+sqrt(-1)*wd)*(t_free-t0))-m*g/k);  
  V0 = real(A*(-zeta*w+sqrt(-1)*wd)*exp((-zeta*w+sqrt(-1)*wd)*(t_free-t0)));
  t0 = t_free ;
  t_next = findImpact(t0,X0,V0) ;
end
% Free flight:
ts = linspace(t0,t_next,1001) ;
t = [t ts(2:end)];
d = [d (-1/2*g*(ts(2:end)-t0).^2+V0*(ts(2:end)-t0)+X0)] ;
end

function t_next = findImpact(t0,X0,V0)
g = 9.81 ;
t_next = (t0+V0/g)+sqrt(V0^2/g^2+2*X0/g) ;
end

function t_next = findFree(t0,V0,m,k,zeta)
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
t_next = fzero(@(t) real((g/w^2-sqrt(-1)*(g/w*zeta+V0)/sqrt(1-zeta^2)/w)*exp((-zeta*w+sqrt(-1)*w*sqrt(1-zeta^2))*(t-t0))-m*g/k), ...
  [t0+pi/wd,t0+3*pi/2/wd],options) ;
end
