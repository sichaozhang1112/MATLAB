% L = 48; % L+2 = 50
% omegas_1=linspace(0,3.14,50);
% omegas_2=2*pi/32:2*pi/32:32*pi/32;
% omegas=linspace(0,pi,50);
data=load('omegas_13.mat');
omegas_1 = data.omegas_1;
omegas_2=2*pi/32:2*pi/32:32*pi/32;
omegas=sort([omegas_1,omegas_2]);
osz=length(omegas);
M=osz;
D_omegas=(omegas<=(pi/32));
c_omegas=cos(omegas);
% gammas
ttt=kron(ones(osz,1),c_omegas);
sss=ttt-ttt'+diag(ones(osz,1));
gammas=1./prod(sss,1);
% DxGamma
DxGamma=D_omegas.*gammas;
%% Beta
kk = kron(ones(M,1),c_omegas);
dd = kk - diag(c_omegas);

for ii = 1 : M
    for jj = 1 : M-1
        if jj < ii 
            ddd(ii,jj) = dd(ii,jj);
        elseif jj >= ii
            ddd(ii,jj) = dd(ii,jj+1);
    end
    end
end

for ii = 1 : M
    pp(ii,:) = poly(ddd(ii,:));
    beta(ii,:) = DxGamma(ii)*pp(ii,:);
end

beta = sum(beta,1);
%
%% Alpha and h
% chebyshev polynomial
cc = zeros(M,M);
cc(1,end) = 1;
cc(2,end-1) = 1;
%%
for ii = 3 : M
    cc(ii,:) = 2*circshift(cc(ii-1,:),-1)-cc(ii-2,:);
end
%%
cc = cc';

alpha = inv(cc)*beta';

h_0 = alpha(1);
h_r = 0.5*alpha(2:end)';
h_fr = fliplr(h_r);
h = [h_fr,h_0,h_r];
%
%% Plot DFT
ww=[0.0001:.01:pi];
sum = 0;
for jj = 1 : length(h)
    sum = sum + h(jj)*exp(-j*ww*(jj-1));
end


figure(2);
plot(ww,real(sum)); 
xlabel('frequency');
ylabel('real part');
title('DFT of h(n)');