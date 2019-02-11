function [yyy] = lagrange_interp(omegas,P_omegas,ww)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

osz=length(omegas);
c_omegas=cos(omegas);
ttt=kron(ones(osz,1),c_omegas);
sss=ttt-ttt'+diag(ones(osz,1));
gammas=prod(sss,1);
PxGamma=P_omegas./gammas;

c_ww=cos(ww);
wsz=length(c_ww);
ttt_ww=kron(ones(wsz,1),c_omegas);
rrr=kron(c_ww',ones(1,osz));
sss_ww=rrr-ttt_ww;
ff_tot=prod(sss_ww,2);
fff=kron(ff_tot,ones(1,osz));
% fff_int=fff./sss_ww;
fff_int=fff./(sss_ww);
yyy=fff_int*PxGamma';

end

