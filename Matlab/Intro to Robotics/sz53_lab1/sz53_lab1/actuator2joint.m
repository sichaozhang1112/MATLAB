function [  joint_angles ] = actuator2joint( actuator_angles )

joint_angles(1) = (15/120) * actuator_angles(1);
joint_angles(2) = (10/80) * actuator_angles(2);
joint_angles(3) = (10/80) * actuator_angles(3);

end

