%%
% a2 = 2;
% a3 = 3;
% a4 = 4;
% T01 = @(theta) [cos(theta),-sin(theta),0,0;
%                 sin(theta),cos(theta),0,0;
%                 0,0,1,0;
%                 0,0,0,1];
% T12 = @(theta) [cos(theta),-sin(theta),0,0;
%                 0,0,1,0;
%                 -sin(theta),-cos(theta),0,0;
%                 0,0,0,1];
% T23 = @(theta) [cos(theta),-sin(theta),0,a2;
%                 sin(theta),cos(theta),0,0;
%                 0,0,1,0;
%                 0,0,0,1];
% T34 = @(theta) [cos(theta),-sin(theta),0,a3;
%                 sin(theta),cos(theta),0,0;
%                 0,0,1,0;
%                 0,0,0,1];
            
% P5 = [a4;0;0;1];
% for tt1 = 1 : 100
%     for tt2 = 1 : 100
%         for tt3 = 1 : 100
%             for tt4 = 1 : 100
%                 t1 = 2*pi*tt1/100;
%                 t2 = 2*pi*tt2/100;
%                 t3 = 2*pi*tt3/100;
%                 t4 = 2*pi*tt4/100;
%                 P1 = T01(t1)*T12(t2)*T23(t3)*T34(t4)*P5;
%             end
%         end
%     end
% end

%%
% 
% l1 = 1;
% l2 = 20;
% l3 = 1;
% 
% for tt1 = 1 : 100
%     for tt2 = 1 : 100
%         for tt3 = 1 : 100
% %             for tt4 = 1 : 100
%             t1 = 2*pi*tt1/100;
%             t2 = 2*pi*tt2/100;
%             t3 = 2*pi*tt3/100;
% %             t4 = 2*pi*tt4/100;
% %             x(tt1*tt2*tt3*tt4) = (l1 * cos(t1) + l2 * cos(t2) + l3 * cos(t3))*cos(t4);
% %             y(tt1*tt2*tt3*tt4) = (l1 * cos(t1) + l2 * cos(t2) + l3 * cos(t3))*sin(t4);
% %             z(tt1*tt2*tt3*tt4) = l1 * sin(t1) + l2 * sin(t2) + l3 * sin(t3);
%             x(tt1*tt2*tt3) = l1 * cos(t1) + l2 * cos(t2) + l3 * cos(t3);
%             y(tt1*tt2*tt3) = l1 * sin(t1) + l2 * sin(t2) + l3 * sin(t3);
% %             end
%         end
%     end
% end
% 
% scatter(x,y);
% grid on;


p11 = [1,2];
p12 = [6,9];
p21 = [5,4];
p22 = [0,0];

coordinate(p11,p12,p21,p22);

l1x = linspace(p11(1),p12(1),1000);
l1y = linspace(p11(2),p12(2),1000);

l2x = linspace(p21(1),p22(1),1000);
l2y = linspace(p21(2),p22(2),1000);

plot(l1x,l1y,'r','linewidth',1.5);
hold on;
plot(l2x,l2y,'b','linewidth',1.5);
hold on;



