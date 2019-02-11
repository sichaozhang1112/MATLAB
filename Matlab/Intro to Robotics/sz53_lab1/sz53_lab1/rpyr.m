function [ rpyr ] = rpyr( angles )

roll = angles(1);
pitch = angles(2);
yaw = angles(3);

rpyr = yawr(yaw) * pitchr(pitch) * rollr(roll);

end

