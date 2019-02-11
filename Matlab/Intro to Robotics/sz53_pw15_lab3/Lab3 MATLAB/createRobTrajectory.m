% Lab3
% Peiguang Wang, Sichao Zhang

function [ trajectory ] = createRobTrajectory( via, rob )
% MECH 498/598 - Intro to Robotics - Spring 2016
% Lab 3
% Solutions by Craig McDonald
%
%    DESCRIPTION - Generate a joint position and velocity trajectory to be
%    used by the controller.
%
%    The input via is a 3x4 matrix containing via points for the end
%    effector. Each column contains a point in 3D space. The trajectory
%    should move sequentially through each via point. The best approach is
%    to simply move in a straight line in cartesian space between the
%    points. Use robIK() to find the corresponding trajectory in joint
%    space.
%
%    The output trajectory is a 7xn matrix. The first row will be
%    equally-spaced time stamps starting at time zero and finishing at time
%    t_f given to you below. Rows 2 through 4 contain joint angles,
%    and rows 5 7 should contain joint velocities.

t_f = 30; % final time (do not change) [s]

dt = 0.1;
t = 0:dt:t_f;

trajectory(1,:) = t; %Time

%
%% first generate dense joint positions
distance1 = abs(norm(via(:,1) - via(:,2)));
distance2 = abs(norm(via(:,2) - via(:,3)));
distance3 = abs(norm(via(:,3) - via(:,4)));
total_distance = distance1 + distance2 + distance3;

% create dense timese
dense_time = [0, distance1/total_distance*t_f, ...
    distance1/total_distance*t_f + distance2/total_distance*t_f, t_f];

% calculate interpolated positions
xx = interp1(dense_time, via(1,:),t);
yy = interp1(dense_time, via(2,:),t);
zz = interp1(dense_time, via(3,:),t);

% Inverse Kinematics
travel_points = [xx; yy; zz];
prev_angles = zeros(3,1);
for ii = 1:length(t)
    [~, trajectory(2:4,ii)] = robIK(travel_points(:,ii),prev_angles, rob);
    prev_angles = trajectory(2:4,ii);
end

% Forward difference
trajectory(5:7,1) = (trajectory(2:4,2) - trajectory(2:4,1))/dt;
% Backwards difference
trajectory(5:7,end) = (trajectory(2:4,end) - trajectory(2:4,end-1))/dt;
% Central difference
for ii = 2:length(t)-1
    % trajectory(5:7,:) = []; %Joiint velocities
    velocities = (trajectory(2:4,ii+1) - trajectory(2:4,ii-1))/(2*dt);
    trajectory(5:7, ii) = velocities;
end


end

