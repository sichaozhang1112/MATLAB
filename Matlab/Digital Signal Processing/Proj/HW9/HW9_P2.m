%%
%% ELEC 558-HW9
%% Sichao Zhang
%%
%% Problem 2
%% Remez Exchange - First Stage
% [0,0.2*pi,0.48*pi,pi]
%% step 1
% L = 7
omegas=[0:0.1:0.2,0.48:0.1:0.98]*pi;
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
peaks1 = findpeaks(epsilon_ww1)
epsilon_ww2 = abs(yyy_ww2);
peaks2 = findpeaks(epsilon_ww2)
% observe and pick new omegas

%% plot
figure(1);
plot(ww,yyy);
hold on;
plot(ww(1:64),ones(64,1));
hold on;
plot(ww(152:315),zeros(164,1));
hold on;
scatter(omegas,P_omegas,'b');
hold on;
xlabel('frequency');
ylabel('real part');
title('Remez Exchange - First Stage');
figure(2);
plot(ww,epsilon_ww1+epsilon_ww2);
hold on;
scatter([peaks1(2,1),peaks2(2,2:end)],[peaks1(1,1),peaks2(1,2:end)]);
hold on;
xlabel('frequency');
ylabel('epsilon');
title('Local Maximum of Epsilon - First Stage');