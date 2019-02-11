function [ rotate ] = rotate( P_B )
% % rotation matrix about x
% Rx = @(theta) [1,0,0;
%                0,cos(theta),-sin(theta);
%                0,sin(theta),cos(theta)];
% rotation matrix about y 
Ry = @(theta) [cos(theta),0,sin(theta);
               0,1,0;
               -sin(theta),0,cos(theta)];
% rotation matrix about z 
Rz = @(theta) [cos(theta),-sin(theta),0;
               sin(theta),cos(theta),0;
               0,0,1];
           
% rotation matrix rotate(P_B)
rotate = Ry(pi/2) * Rz(pi/4) * P_B;

end

