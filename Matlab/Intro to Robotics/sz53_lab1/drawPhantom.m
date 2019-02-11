function [ handles ] = drawPhantom( actuator_angles, gimbal_angles )
% MECH 498/598 - Intro to Robotics - Spring 2016
% Lab 1
% Solutions by Craig McDonald
%
%    Plot a graphical representation of the PHANToM Premium robot with
%    attached coordinate frames.
%
%    phantom is a structure generated by phantomInit()
%
%    handles is a vector of graphics handles corresponding to the moving
%    frames attached to the robot
%
      
% Phantom link and frame colors (three RGB values between 0 and 1)
colors{1} = [0.8,0,0]; % link 1 and frame 1 color
colors{2} = [0,0.8,0]; % link 2 and frame 2 color
colors{3} = [0,0,0.8]; % link 3 and frame 3 color
colors{4} = [0.5,0,0.5]; % end effector frame color
colors{5} = [0,0.6,0.6]; % gimbal frame color

% Plotting workspace
workspace = [-200,200,-200,200,0,400];

% Convert actuator angles to joint angles
joint_angles = actuator2joint(actuator_angles);

% Create structure of PHANToM forward kinematics transforms
[~,phantom_T] = phantomFK(joint_angles,gimbal_angles);

Porg_1 = phantom_T{1}(1:3,4);
Porg_2 = phantom_T{2}(1:3,4);
Porg_3 = phantom_T{3}(1:3,4);
Porg_e = phantom_T{4}(1:3,4);

% Plot scaling properties
origin_size = 20;
marker_size = 10;
vector_size = 0.05*max(abs(diff(reshape(workspace,2,3))));
base_size = 50;

% Create figure window
figure('Color','w');

% Create axes object
ax = axes('XLim',workspace(1:2),'YLim',workspace(3:4),...
   'ZLim',workspace(5:6));
view(3);
grid on;
axis equal;
xlabel('X (mm)','FontSize',16);
ylabel('Y (mm)','FontSize',16);
zlabel('Z (mm)','FontSize',16);
set(gca,'View',[147.3,22.8]);

% Create frames and links
h = drawRobotFrame([0,0,0]);
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_0 = line(base_size*cos(0:1e-2:2*pi),base_size*sin(0:1e-2:2*pi),...
    0*ones(length(0:1e-2:2*pi)),...
    'Color','k','LineWidth',1.5);
set(L_0,'Parent',hg);
T_0 = hgtransform('Parent',ax,'Matrix',eye(4));
set(hg,'Parent',T_0);

h = drawRobotFrame(colors{1});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_1 = line([0,Porg_1(1)],[0,Porg_1(2)],[0,-Porg_1(3)],...
    'Color',colors{1},'LineWidth',1.5);
set(L_1,'Parent',hg);
T_1 = hgtransform('Parent',T_0,'Matrix',phantom_T{1});
set(hg,'Parent',T_1);

h = drawRobotFrame(colors{2});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_2 = line([0,Porg_3(1)],[0,Porg_3(2)],[0,Porg_3(3)],...
    'Color',colors{2},'LineWidth',1.5);
set(L_2,'Parent',hg);
T_2 = hgtransform('Parent',T_1,'Matrix',phantom_T{2});
set(hg,'Parent',T_2);

h = drawRobotFrame(colors{3});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_3 = line([0,Porg_e(1)],[0,Porg_e(2)],[0,Porg_e(3)],...
    'Color',colors{3},'LineWidth',1.5);
set(L_3,'Parent',hg);
T_3 = hgtransform('Parent',T_2,'Matrix',phantom_T{3});
set(hg,'Parent',T_3);

h = drawRobotFrame(colors{4});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
T_4 = hgtransform('Parent',T_3,'Matrix',phantom_T{4});
set(hg,'Parent',T_4);

h = drawRobotFrame(colors{5});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
T_5 = hgtransform('Parent',T_4,'Matrix',phantom_T{5});
set(hg,'Parent',T_5);

set(gcf,'Renderer','openGL');
drawnow;

% Return hgtransform handles
handles = [T_1,T_2,T_3,T_4,T_5];

    function h = drawRobotFrame( color )
         
        % Plot reference frame
        X_b = [vector_size,0,0,1]';
        Y_b = [0,vector_size,0,1]';
        Z_b = [0,0,vector_size,1]';
        h(1) = line(0,0,0,'Marker','.','MarkerSize',origin_size,'Color',color);
        h(2) = line([0,X_b(1)],[0,X_b(2)],[0,X_b(3)],'LineWidth',1.5,'Color',color);
        h(3) = line([0,Y_b(1)],[0,Y_b(2)],[0,Y_b(3)],'LineWidth',1.5,'Color',color);
        h(4) = line([0,Z_b(1)],[0,Z_b(2)],[0,Z_b(3)],'LineWidth',1.5,'Color',color);
        h(5) = line(X_b(1),X_b(2),X_b(3),'LineWidth',1.5,'Marker','x','MarkerSize',marker_size,'Color',color);
        h(6) = line(Y_b(1),Y_b(2),Y_b(3),'LineWidth',1.5,'Marker','o','MarkerSize',marker_size,'Color',color);
        h(7) = line(Z_b(1),Z_b(2),Z_b(3),'LineWidth',1.5,'Marker','d','MarkerSize',marker_size,'Color',color);
    end


end