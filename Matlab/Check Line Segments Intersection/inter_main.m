P11 = [0,0];
P12 = [10,10];
P21 = [1,2];
P22 = [2,1];

l1x = linspace(P11(1),P12(1),1000);
l1y = linspace(P11(2),P12(2),1000);

l2x = linspace(P21(1),P22(1),1000);
l2y = linspace(P21(2),P22(2),1000);

check = check_inter(P11,P12,P21,P22)

plot(l1x,l1y,'r','linewidth',1.5);
hold on;
plot(l2x,l2y,'b','linewidth',1.5);
hold on;
