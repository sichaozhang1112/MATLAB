function [ rollr ] = rollr( roll )

% roll
rollr = [1,0,0;
         0,cos(roll),-sin(roll);
         0,sin(roll),cos(roll)];
end

