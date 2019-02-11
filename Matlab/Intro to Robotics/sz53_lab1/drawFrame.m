function drawFrame( transform, color)
% MECH 498/598 - Intro to Robotics - Spring 2016
% Lab #1
% Solutions by Craig McDonald
%
%    Plot a reference frame described by the give homogeneous transform.
%    Draw the frame in the given color.
%
%    

% Check color input argument
if nargin > 1
    if ~isequal(size(color),[1,3])
        error('Input argument "color" must be a 3 element row vector')
    end
    for i = 1:3
        if color(i) < 0 || color(i) > 1
            error('All 3 elements of input argument "color" cannot be outside range 0 to 1')
        end
    end
else
    color = [0,0,1]; % set default color to blue
end

% Extract position vector from transform
p = transform(1:3,4);

% Creat figure window
figure('color','w');

% Plot scale variables
origin_size = 20;
marker_size = 10;

% Plot world frame
plot3(0,0,0,'k.','MarkerSize',origin_size);
hold on;
plot3([0,1],[0,0],[0,0],'k','LineWidth',1.5);
plot3([0,0],[0,1],[0,0],'k','LineWidth',1.5);
plot3([0,0],[0,0],[0,1],'k','LineWidth',1.5);
plot3(1,0,0,'k','LineWidth',1.5,'Marker','x','MarkerSize',marker_size);
plot3(0,1,0,'k','LineWidth',1.5,'Marker','o','MarkerSize',marker_size);
plot3(0,0,1,'k','LineWidth',1.5,'Marker','d','MarkerSize',marker_size);

% Plot body frame
X_b = transform*[1,0,0,1]';
Y_b = transform*[0,1,0,1]';
Z_b = transform*[0,0,1,1]';
plot3(p(1),p(2),p(3),'.','MarkerSize',origin_size,'Color',color);
plot3([p(1),X_b(1)],[p(2),X_b(2)],[p(3),X_b(3)],'LineWidth',1.5,'Color',color);
plot3([p(1),Y_b(1)],[p(2),Y_b(2)],[p(3),Y_b(3)],'LineWidth',1.5,'Color',color);
plot3([p(1),Z_b(1)],[p(2),Z_b(2)],[p(3),Z_b(3)],'LineWidth',1.5,'Color',color);
plot3(X_b(1),X_b(2),X_b(3),'LineWidth',1.5,'Marker','x','MarkerSize',marker_size,'Color',color);
plot3(Y_b(1),Y_b(2),Y_b(3),'LineWidth',1.5,'Marker','o','MarkerSize',marker_size,'Color',color);
plot3(Z_b(1),Z_b(2),Z_b(3),'LineWidth',1.5,'Marker','d','MarkerSize',marker_size,'Color',color);

% Set plot properties
xlabel('X','FontSize',16);
ylabel('Y','FontSize',16);
zlabel('Z','FontSize',16);
title('Plot Single Frame','FontSize',20);
grid on;
axis equal;
hold off;
rotate3d;



end