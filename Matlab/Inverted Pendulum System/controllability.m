clear;
m = 0.1;
M = 2;
l = 0.5;
g = 9.8;
A = [0,1,0,0;
    0,0,-m*g/M,0;
    0,0,0,1;
    0,0,(m+M)*g/(M*l),0];
B = [0;1/M;0;-1/(M*l)];
l = [B,A*B,A*A*B,A*A*A*B];
rank = rank(l)