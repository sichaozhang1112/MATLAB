syms t1;
syms t2;
syms t3;
syms l1;
syms l2;
syms l3;

DH = zeros(4,4);
DH(1,3) = l1;
DH(1,4) = t1;
DH(2,1) = 0;
DH(2,4) = t2;
DH(3,2) = l2;
DH(3,4) = t3;
DH(4,2) = l3;

