% Lab3
% Peiguang Wang, Sichao Zhang

function [ tau ] = robController( trajectory, Theta, Theta_dot, t , rob )
% MECH 498/598 - Intro to Robotics - Spring 2016
% Lab 3
% Solutions by Craig McDonald
%
%    DESCRIPTION - This function sends command torques in the vector tau to move the
%    robot. The controller determines tau based on the desired position and
%    velocity and the actual position and velocity. Desired position and
%    velocity are obtained from trajectory and the current time t. The
%    actua position is Theta, and the actual velocity is Theta_dot.
%    Calculate the torques needed to add gravity compensation using the
%    robot parameters from the structure rob.
%

% Robot Parameters from rob
g = rob.parameters.g;
b = rob.parameters.b;
m1 = rob.parameters.m1;
m2 = rob.parameters.m2;
m3 = rob.parameters.m3;
m4 = rob.parameters.m4;
l1 = rob.parameters.l1*1e-3;
l2 = rob.parameters.l2*1e-3;
l3 = rob.parameters.l3*1e-3;
...
    
% Gravity Compensation Vector
G = [0; g*m2*l2/2*cos(Theta(2)) + g*m3*(l2*cos(Theta(2)) + l3/2*cos(Theta(2)+Theta(3))) ...
    + g*m4*(l2*cos(Theta(2)) + l3*cos(Theta(2) + Theta(3)));
    g*m3*l3/2*cos(Theta(2)+Theta(3)) + g*m4*l3*cos(Theta(2) + Theta(3))];

% Trajectory interpolation (DO NOT CHANGE)
Theta_ref = zeros(3,1);
Theta_dot_ref = zeros(3,1);
for i = 1:3
    Theta_ref(i) = interp1(trajectory(1,:),trajectory(i+1,:),t);
    Theta_dot_ref(i) = interp1(trajectory(1,:),trajectory(i+4,:),t);
end

% Gravity Compensation Control

K_p = 100*eye(3); % Proportional gain matrix containing gains K_p1 to K_p3
K_v = 100*eye(3); % Derivative gain matrix containing gains K_v1 to K_v3

tau = - K_p*(Theta - Theta_ref) - K_v*(Theta_dot - Theta_dot_ref) + G; % control input (torque)

end

