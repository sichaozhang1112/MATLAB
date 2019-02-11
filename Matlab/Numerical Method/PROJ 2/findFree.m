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