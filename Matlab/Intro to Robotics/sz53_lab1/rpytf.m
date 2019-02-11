function [ rpytf ] = rpytf( twist )

x = twist(1);
y = twist(2);
z = twist(3);
angles = twist(4:6);

rpyr = rpyr(angles);

rpytf = padarray(rpyr,1,'post')';
rpytf = padarray(rpytf,1,'post');

rpytf(1:4,4) = [x,y,z,1];

end

