function movePhantom( path_file )
% MECH 498/598 - Intro to Robotics - Spring 2016
% Lab 1
% Solutions by Craig McDonald
% 
%    Plot a graphical representation of the PHANToM Premium haptic robot with
%    attached coordinate frames as it moves through a series of poses
%    defined by path_file.
%    

% Load path data
data = load(path_file);
s = data.s;

% Draw PHANToM initially in zero position
actuator_angles = [0,0,0];
gimbal_angles = [0,0,0];
handles = drawPhantom(actuator_angles,gimbal_angles);
hold on;

% Draw in 3D
for t = 1:size(s,2)

    % Move robot
    actuator_angles = s(1:3,t)';
    gimbal_angles = s(4:6,t)';
    joint_angles = actuator2joint(actuator_angles);
    [phantom_T_0_g,phantom_T] = phantomFK(joint_angles,gimbal_angles);
    plot3(phantom_T_0_g(1,4),phantom_T_0_g(2,4),phantom_T_0_g(3,4),'.b'); % plot a point at the wrist for each step
    set(handles(1),'Matrix',phantom_T{1});
    set(handles(2),'Matrix',phantom_T{2});
    set(handles(3),'Matrix',phantom_T{3});
    set(handles(4),'Matrix',phantom_T{4});
    set(handles(5),'Matrix',phantom_T{5});
    drawnow;
    pause(0.01); % pause for a certain number of seconds
end

end




