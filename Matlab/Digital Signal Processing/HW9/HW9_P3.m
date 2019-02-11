%%
%% ELEC 558-HW9
%% Sichao Zhang
%%
%% Problem 3
%% Remez Exchange
% [0,0.2*pi,0.48*pi,pi]
Omegas(1,:) = [0:0.1:0.2,0.48:0.1:0.98]*pi;
Omegas(2,:) = [0,0.2*pi,0.4801,0.48*pi,1.6501,2.0201,2.3901,2.7601,pi];
Omegas(3,:) = [0,0.3101,0.2*pi,0.48*pi,1.6401,1.9501,2.3401,2.7401,pi];
Omegas(4,:) = [0,0.4601,0.2*pi,0.48*pi,1.6401,1.9501,2.3301,2.7301,pi];
Omegas(5,:) = [0,0.4701,0.2*pi,0.48*pi,1.6401,1.9501,2.3301,2.74,pi];
Omegas(6,:) = [0,0.4801,0.2*pi,0.48*pi,1.6401,1.9501,2.3301,2.7301,pi];
%% step 1
for ii = 1 : 6
% L = 7
omegas=Omegas(ii,:);
osz=length(omegas);
D_omegas=(omegas<=(pi/5));
c_omegas=cos(omegas);

%% step 2
% gammas
ttt=kron(ones(osz,1),c_omegas);
sss=ttt-ttt'+diag(ones(osz,1));
gammas=1./prod(sss,1);
% DxGamma
DxGamma=D_omegas.*gammas;

seq = (-1).^[0:(osz-1)];

% epsilon
epsilon = (-sum(DxGamma)/sum(gammas.*seq));
Epsilon(:,ii) = epsilon;

%% step 3
% P_omegas
P_omegas = D_omegas + seq.*epsilon;

%% step 4
ttt_1=kron(ones(osz-1,1),c_omegas(1:end-1));
sss_1=ttt_1-ttt_1'+diag(ones(osz-1,1));
gammas_1=1./prod(sss_1,1);
PxGamma=P_omegas(1:end-1).*gammas_1;

ww=[0.0001:.01:pi];
c_ww=cos(ww);
wsz=length(c_ww);
ttt_ww=kron(ones(wsz,1),c_omegas(1:end-1));
rrr=kron(c_ww',ones(1,osz-1));
sss_ww=rrr-ttt_ww;
ff_tot=prod(sss_ww,2);
fff=kron(ff_tot,ones(1,osz-1));
fff_int=fff./sss_ww;
yyy=fff_int*PxGamma';

%% step 5
D_ww1 = (ww<=(pi/5));
D_ww2 = (ww>=(0.48*pi));
yyy_ww1 = yyy.*D_ww1';
yyy_ww2 = yyy.*D_ww2';
epsilon_ww1 = abs(yyy_ww1-D_ww1');
peaks1 = findpeaks(epsilon_ww1);
epsilon_ww2 = abs(yyy_ww2);
peaks2 = findpeaks(epsilon_ww2);
% observe and pick new omegas

%% plot
figure(1);
plot(ww,yyy);
hold on;
% scatter(omegas,P_omegas);
% hold on;
end
%%
xlabel('frequency');
ylabel('real part');
title('Remez Exchange');
legend('1st','2nd','3rd','4th','5th','6th');