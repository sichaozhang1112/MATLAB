function [T,T_inv] = euler2ht(angles,pos)

alpha = angles(1);
beta = angles(2);
gamma = angles(3);

rot = [cos(alpha)*cos(beta),cos(alpha)*sin(beta)*sin(gamma)-sin(alpha)*cos(gamma),cos(alpha)*sin(beta)*cos(gamma)+sin(alpha)*sin(gamma);
       sin(alpha)*cos(beta),sin(alpha)*sin(beta)*sin(gamma)+cos(alpha)*cos(gamma),sin(alpha)*sin(beta)*cos(gamma)-cos(alpha)*sin(gamma);
       -sin(beta),cos(beta)*sin(gamma),cos(beta)*cos(gamma)];
T = padarray(rot,1,'post')';
T = padarray(T,1,'post');

T(1:3,4) = pos(1:3);
T(4,4) = 1;

T_inv = inv(T);
end
