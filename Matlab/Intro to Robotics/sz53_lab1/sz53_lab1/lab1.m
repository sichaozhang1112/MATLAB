%
%% MECH 598 - Lab 1
%% Sichao Zhang
%
%% Probelm 3
 
% example 1 
P1_B = [0,0,1]';
P1_A = rotate(P1_B); 

% example 2 
P2_B = [0,1,0]';
P2_A = rotate(P2_B); 

%
%% Problem 4

% example 1
angles1 = [pi/4,pi/3,pi/6];
pos1 = [1,2,3]';
[T1,T1_inv] = euler2ht(angles1,pos1);

%
%% Problem 5 

% a)

rollr1 = zeros(1000,9);
pitchr1 = zeros(1000,9);
yawr1 = zeros(1000,9);

for ii = 1 : 1001
    
roll_mat = rollr((1/1000)*(ii-1)*2*pi);
rollr1(ii,1:3) = roll_mat(1,:);
rollr1(ii,4:6) = roll_mat(2,:);
rollr1(ii,7:9) = roll_mat(3,:);

pitch_mat = pitchr((1/1000)*(ii-1)*2*pi);
pitchr1(ii,1:3) = pitch_mat(1,:);
pitchr1(ii,4:6) = pitch_mat(2,:);
pitchr1(ii,7:9) = pitch_mat(3,:);

yaw_mat = yawr((1/1000)*(ii-1)*2*pi);
yawr1(ii,1:3) = yaw_mat(1,:);
yawr1(ii,4:6) = yaw_mat(2,:);
yawr1(ii,7:9) = yaw_mat(3,:);

end

figure();
plot3(rollr1(:,4),rollr1(:,5),rollr1(:,6),'r');
hold on;
plot3(pitchr1(:,7),pitchr1(:,8),pitchr1(:,9),'b');
hold on;
plot3(yawr1(:,1),yawr1(:,2),yawr1(:,3),'g');
hold on;
grid on;

% b)

%
%% Problem 6

% example 1
angles1 = [pi/1,pi/2,pi/3];

rpyr1 = rpyr(angles1);

% example 2
angles2 = [pi/4,pi/6,pi/3];

rpyr2 = rpyr(angles2);

%
%% Problem 7

% example 1







