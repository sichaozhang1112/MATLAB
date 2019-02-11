function [ phantom_T_0_g,phantom_T ] = phantomFK( joint_angles,gimbal_angles )

DH = zeros(4,4);
DH(1,3) = 139;
DH(1,4) = joint_angles(1);
DH(2,1) = -pi/2;
DH(2,4) = joint_angles(2);
DH(3,2) = 140;
DH(3,4) = joint_angles(3);
DH(4,2) = 62;

alpha = DH(:,1);
a = DH(:,2);
d = DH(:,3);
theta = DH(:,4);

rpyr_g = rpyr(gimbal_angles);
rpyr_g = padarray(rpyr_g,1,'post')';
rpyr_g = padarray(rpyr_g,1,'post');
rpyr_g(4,4) = 1;

T01 = screwDH(a(1),alpha(1),d(1),theta(1));
T12 = screwDH(a(2),alpha(2),d(2),theta(2));
T23 = screwDH(a(3),alpha(3),d(3),theta(3));
T34 = screwDH(a(4),alpha(4),d(4),theta(4));
T45 = rpyr_g;

phantom_T_0_g = T01*T12*T23*T34*T45;

phantom_T = {T01,T12,T23,T34,T45};

end
