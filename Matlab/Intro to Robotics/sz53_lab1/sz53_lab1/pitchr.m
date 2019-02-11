function [ pitchr ] = pitchr( pitch )

% pitch
pitchr = [cos(pitch),0,sin(pitch);
          0,1,0;
          -sin(pitch),0,cos(pitch)];

end

