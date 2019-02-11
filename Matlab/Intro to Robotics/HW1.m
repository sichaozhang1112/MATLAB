% MECH 598 HW1
y = pi;
z = 143.1 * pi / 180;
% kx = 0;
% ky = 0;
% kz = 1;
% v = 1 - cos(z);
% Rx = [1,0,0;
%       0,cos(x),-sin(x);
%       0,sin(x),cos(x)];
Ry = [cos(y),0,sin(y);
      0,1,0;
      -sin(y),0,cos(y)];
Rz = [cos(z),-sin(z),0;
      sin(z),cos(z),0;
      0,0,1];
% Rk = [cos(z),-kz*sin(z),0;
%       sin(z),cos(z),0;
%       0,0,1];
Ry = padarray(Ry)
a = Ry * Rz
% Rx_1 = [1,0,0;
%       0,cos(x_1),-sin(x_1);
%       0,sin(x_1),cos(x_1)];
% Rx_2 = [1,0,0;
%       0,cos(x_2),-sin(x_2);
%       0,sin(x_2),cos(x_2)];
%   
% a = Rx_2 * Ry * Rz * Rx_1
%   

% a = [-0.8,0,-0.6,3;
%      0.6,0,-0.8,0;
%      0,-1,0,0;
%      0,0,0,1];
% b = [-1,0,0,0;
%     0,0,1,4;
%     0,1,0,2;
%     0,0,0,1];
% 
% c = b * a

% T = [cos(pi/4),-sin(pi/4),0,6;
%     sin(pi/4),cos(pi/4),0,3;
%     0,0,1,-4;
%     0,0,0,1];
% F_B = [1;7;3;1];
% F_A = T * F_B
