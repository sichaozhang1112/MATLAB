function [res] = getEpsilon(omegas,D_omegas)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

osz=length(omegas);
c_omegas=cos(omegas);
ttt=kron(ones(osz,1),c_omegas);
sss=ttt-ttt'+diag(ones(osz,1));
gammas= prod(sss,1);
gammas = 1./gammas;
DxGamma=D_omegas.*gammas;

alternating = (-1).^[0:length(omegas)-1];
deNominator = sum(gammas.*alternating);

res = -sum(DxGamma)/deNominator;

end

