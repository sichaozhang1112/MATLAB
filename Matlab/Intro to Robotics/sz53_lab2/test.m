angle_joints = [0,0,0,0,0,0];
fanuc = fanucInit();
%%
% Create a cell array of FANUC forward kinematics transforms
[~,fanuc_T] = fanucFK(joint_angles,fanuc);

% Shorten variable names
l_1 = fanuc.parameters.l_1;
l_2 = fanuc.parameters.l_2;
l_3 = fanuc.parameters.l_3;
l_4 = fanuc.parameters.l_4;
l_5 = fanuc.parameters.l_5;
l_6 = fanuc.parameters.l_6;

l_t = fanuc.parameters.l_t;
l_t_rad = fanuc.parameters.l_t_rad;

% Plot scaling properties
origin_size = 20;
marker_size = 10;
vector_size = 0.05*max(abs(diff(reshape(fanuc.workspace,2,3))));

% Create figure window
figure('Color','w');

% Create axes object
ax = axes('XLim',fanuc.workspace(1:2),'YLim',fanuc.workspace(3:4),...
   'ZLim',fanuc.workspace(5:6));
vw = [31.3,22.8];
set(gca,'View',vw);
grid on;
axis equal;
xlabel('X (mm)','FontSize',16);
ylabel('Y (mm)','FontSize',16);
zlabel('Z (mm)','FontSize',16);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Draw Robot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% Create link 0 and frame 0
h = drawRobotFrame([0,0,0]);
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
circ = linspace(0,2*pi,50);
L_0 = line(100*cos(circ),100*sin(circ),-l_1*ones(length(circ)),'Color','k','LineWidth',1.5);
set(L_0,'Parent',hg);
T_0 = hgtransform('Parent',ax,'Matrix',makehgtform('translate',[0,0,l_1]));
set(hg,'Parent',T_0);

% Create link 1 and frame 1
h = drawRobotFrame(fanuc.colors{1});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_1 = line([0,0,l_2],[0,0,0],[-l_1,0,0],'Color',fanuc.colors{1},'LineWidth',1.5);
set(L_1,'Parent',hg);
T_1 = hgtransform('Parent',T_0,'Matrix',fanuc_T{1});
set(hg,'Parent',T_1);

% Create link 2 and frame 2
h = drawRobotFrame(fanuc.colors{2});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_2 = line([l_2,l_2],[0,0],[0,l_3],'Color',fanuc.colors{2},'LineWidth',1.5);
set(L_2,'Parent',hg);
T_2 = hgtransform('Parent',T_1,'Matrix',fanuc_T{2});
set(hg,'Parent',T_2);

% Create link 3 and frame 3
h = drawRobotFrame(fanuc.colors{3});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_3 = line([l_2,l_2,l_2+l_5],[0,0,0],[l_3,l_3+l_4,l_3+l_4],'Color',fanuc.colors{3},'LineWidth',1.5);
set(L_3,'Parent',hg);
T_3 = hgtransform('Parent',T_2,'Matrix',fanuc_T{3});
set(hg,'Parent',T_3);

% Create link 4 and frame 4
h = drawRobotFrame(fanuc.colors{3});
hg = hggroup('Parent',ax);
set(h,'Parent',hg);
L_4 = line([l_2+l_5,l_2+l_5+l_6],[0,0],[l_3+l_4,l_3+l_4],'Color',fanuc.colors{4},'LineWidth',1.5);
set(L_4,'Parent',hg);
T_4 = hgtransform('Parent',T_3,'Matrix',fanuc_T{4});
set(hg,'Parent',T_4);
%
function h = drawRobotFrame( color )
    fanuc = 
    vector_size = 0.05*max(abs(diff(reshape(fanuc.workspace,2,3))));

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
%