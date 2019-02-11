%%
%% ELEC 558-HW9
%% Sichao Zhang
%%
%% Problem 1
%% HW9_lagrange_interp
omegas=.2+[0:.4:pi];

osz=length(omegas);
D_omegas=(omegas<(pi/3));
c_omegas=cos(omegas);
ttt=kron(ones(osz,1),c_omegas);
sss=ttt-ttt'+diag(ones(osz,1));
gammas=prod(sss,1);
DxGamma=D_omegas./gammas;

ww=[0.0001:.01:pi];
c_ww=cos(ww);
wsz=length(c_ww);
ttt_ww=kron(ones(wsz,1),c_omegas);
rrr=kron(c_ww',ones(1,osz));
sss_ww=rrr-ttt_ww;
ff_tot=prod(sss_ww,2);
fff=kron(ff_tot,ones(1,osz));
fff_int=fff./sss_ww;
yyy=fff_int*DxGamma';
%%
figure(1); 
hold off; 
plot(ww,yyy);
xlabel('frequency');
ylabel('real part');
title('yyy Produced by Lagrange Interplotion');
%% Beta
kk = kron(ones(8,1),c_omegas);
dd = kk - diag(c_omegas);

for ii = 1 : 8
    for jj = 1 : 7
        if jj < ii 
            ddd(ii,jj) = dd(ii,jj);
        elseif jj >= ii
            ddd(ii,jj) = dd(ii,jj+1);
    end
    end
end

for ii = 1 : 8
    pp(ii,:) = poly(ddd(ii,:));
    beta(ii,:) = DxGamma(ii)*pp(ii,:);
end

beta = sum(beta,1);
%
%% Alpha and h
% chebyshev polynomial
cc = zeros(8,8);
cc(1,:) = [0,0,0,0,0,0,0,1];
cc(2,:) = [0,0,0,0,0,0,1,0];
for ii = 3 : 8
    cc(ii,:) = 2*circshift(cc(ii-1,:),-1)-cc(ii-2,:);
end
cc = cc';

alpha = inv(cc)*beta';

h_0 = alpha(1);
h_r = 0.5*alpha(2:end)';
h_fr = fliplr(h_r);
h = [h_fr,h_0,h_r];
%
%% Plot DFT
ww=[0.0001:.01:pi];
for ii = 1 : length(ww)
    for jj = 1 : 15
        zz(jj,:) = exp(-j*ww(ii)*(jj-8));
    end
    yy(:,ii) = h*zz;
end
figure(2);
plot(ww,real(yy)); 
xlabel('frequency');
ylabel('real part');
title('DFT of h(n)');