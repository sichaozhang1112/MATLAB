% Name:
%   Peiguang Wang
%   Sichao Zhang

function [is_solution,joint_angles] = fanucIK(T,prev_joint_angles,fanuc)
% Takes as its inputs a transform T describing the desired position and 
% orientation of the end effector (NOT the tool), a 6-element vector of 
% the previous FANUC joint angles, and the structure output by the 
% function fanucInit, and returns the Boolean variable is_solution,
% and the 6-element vector joint_angles

% parameter setting
l_2 = fanuc.parameters.l_2;
l_3 = fanuc.parameters.l_3;
l_4 = fanuc.parameters.l_4;
l_5 = fanuc.parameters.l_5;

alpha = [0,pi/2,0,pi/2,-pi/2,pi/2];
a = [0,300,900,180,0,0];
d = [0,0,0,1600,0,180];
l6 = 180;

res = zeros(4,6);

is_solution = true;

% workspace checking
endeff_x = T(1,4);
endeff_y = T(2,4);
endeff_z = T(3,4);
if sqrt(endeff_x^2+endeff_y^2)>2739 || endeff_x<-2739*cos(pi/6) || endeff_z>3238 || endeff_z<-721 
    is_solution = false;
    return;
end

% solve for theta1, theta2, theta3
Point5 = T(1:3,4) - T(1:3,1:3)*[0; 0; l_4];

x5 = Point5(1);
y5 = Point5(2);
z5 = Point5(3);

%%%%%%%%%%%%%%%%%%%%%% I have some doubt about the following code
theta1=atan(y5/x5);
res(:,1) = ones(1,4)'*theta1;
if round(sin(theta1)*1000)/1000 == 0
    if round(theta1*1000)/1000 ~= 0
        if theta1 > 0
            theta1 = theta1 - pi;
        end
        if theta1 < 0
            theta1 = theta1 + pi;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%

% sovle for theta2, using results from last homework
l1_tmp = 900;
l2_tmp = sqrt(180*180+1600*1600);
alpha_tmp = atan2(180,1600);

tmp_a = sqrt(x5.^2+y5.^2)-300;
tmp_b = z5;

beta = atan2(tmp_b,tmp_a);

tmp = acos((tmp_a^2+tmp_b^2+l1_tmp^2-l2_tmp^2)/(2*l1_tmp*sqrt(tmp_a^2+tmp_b^2)));
if (tmp < 0)
    tmp = tmp + pi;
elseif (tmp > pi)
    tmp = tmp - pi;
end
theta2_1 = (beta + tmp) - pi/2;
theta2_2 = (beta - tmp) - pi/2;

c3 = (tmp_a.^2 + tmp_b.^2-l1_tmp.^2-l2_tmp.^2)/(2*l1_tmp*l2_tmp);
theta3_1 = pi/2 - alpha_tmp + acos(c3); % one of the solution
theta3_2 = pi/2 - alpha_tmp - acos(c3);

if acos(c3) > 0
    theta2_a = theta2_2; theta3_a = theta3_1;
    theta2_b = theta2_1; theta3_b = theta3_2;
    res(:,2) = [theta2_2, theta2_1, theta2_2, theta2_1]';
else
    theta2_a = theta2_1; theta3_a = theta3_1;
    theta2_b = theta2_2; theta3_b = theta3_2;
    res(:,2) = [theta2_1, theta2_2, theta2_1, theta2_2]';
end
res(:,3) = [theta3_1, theta3_2, theta3_1, theta3_2]';

% solve for theta4, theta5, and theta6
for i = 1:2
    joint_angles = res(i,:);
    
    T01 = dhtf(0,0,0,joint_angles(1));
    T12 = dhtf(pi/2,l_2,0,joint_angles(2)+pi/2);
    T23 = dhtf(0,l_3,0,joint_angles(3));
    T34 = dhtf(pi/2,l_4,l_5,0);
    R01 = T01(1:3,1:3); R12 = T12(1:3,1:3);
    R23 = T23(1:3,1:3); R34 = T34(1:3,1:3);
    R04 = R01*R12*R23*R34; 
    R = R04'*T(1:3,1:3);
    
    %theta 5 solutions
    if round(R(3,3)*10000)/10000 ~= 1 || round(R(3,3)*10000)/10000 ~= -1
        B1 = atan2(sqrt(R(3,1)^2+R(3,2)^2),R(3,3));
        B2 = atan2(-sqrt(R(3,1)^2+R(3,2)^2),R(3,3));
        res(i,5) = B1;
        res(i+2,5) = B2;

        %theta 4
        res(i,4) = atan2(R(2,3)/sin(B1),R(1,3)/sin(B1));
        res(i+2,4) = atan2(R(2,3)/sin(B2),R(1,3)/sin(B2));
        %theta 6
        res(i,6) = atan2(R(3,2)/sin(B1),-R(3,1)/sin(B1));
        res(i+2,6) = atan2(R(3,2)/sin(B2),-R(3,1)/sin(B2));

    end
end

% chose a nearest one
distance1 = norm(prev_joint_angles-res(1,:));
distance2 = norm(prev_joint_angles-res(2,:));
distance3 = norm(prev_joint_angles-res(3,:));
distance4 = norm(prev_joint_angles-res(4,:));
distance = [distance1,distance2,distance3,distance4];
[minValue,minPos] = min(distance);
joint_angles = res(minPos,:);

% check joint limit
for ii = 1:6
    limit = fanuc.joint_limits{ii};
    if(joint_angles(ii)<limit(1) || joint_angles(ii)>limit(2))
        is_solution = false;
        return;
    end
end

end

