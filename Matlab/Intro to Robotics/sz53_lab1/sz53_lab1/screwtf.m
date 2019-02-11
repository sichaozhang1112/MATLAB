function [ screwtf ] = screwtf( translation,rotation,ax )

kx = ax(1);
ky = ax(2);
kz = ax(3);
theta = rotation;
tr = translation;
ct = cos(theta);
st = sin(theta);
vt = 1- ct;

screwtf = [kx*kx*vt+ct,kx*ky*vt-kz*st,kx*kz*vt+ky*st,tr*kx;
           kx*ky*vt+kz*st,ky*ky*vt+ct,ky*kz*vt-kx*st,tr*ky;
           kx*kz*vt-ky*st,ky*kz*vt+kx*st,kz*kz*vt+ct,tr*kz;
           0,0,0,1];

end

