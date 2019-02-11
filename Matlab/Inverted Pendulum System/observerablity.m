clear;
m = 0.1;
M = 2;
l = 0.5;
g = 9.8;
A = [0,1,0,0;
    0,0,-m*g/M,0;
    0,0,0,1;
    0,0,(m+M)*g/(M*l),0];
C = [1,0,0,0;
    0,0,1,0];
theta = [C;C*A;C*A*A;C*A*A*A];
rank = rank(theta)