function [ screwDH ] = screwDH( a,alpha,d,theta )

axx = [1,0,0];
axz = [0,0,1];

screwDH = screwtf(a,alpha,axx) * screwtf(d,theta,axz);

end

