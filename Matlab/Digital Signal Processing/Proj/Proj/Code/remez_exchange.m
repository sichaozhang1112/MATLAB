% function [ newomegas_1,max_num1,max_num2 ] = remez_exchange( omegas_1 )
%% step 1
L = 48; % L+2 = 50
% omegas_1=linspace(0,3.14,50);
omegas_2=2*pi/32:2*pi/32:32*pi/32;
% omegas=linspace(0,pi,50);
omegas=sort([omegas_1,omegas_2]);
osz=length(omegas);
D_omegas=(omegas<=(pi/32));
c_omegas=cos(omegas);

G_omegas = ones(1,size(omegas,2));
for ii = 1 : size(omegas,2)
    for jj = 1 : size(omegas_2,2)
        if omegas(ii) == omegas_2(jj)
            G_omegas(ii) = 0;
        end
    end
end

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
% Epsilon(:,ii) = epsilon;

%% step 3
% P_omegaslinspace(0,pi,32)
P_omegas = (D_omegas + seq.*epsilon).*G_omegas;
% P_omegas = (D_omegas + seq.*epsilon);
%% step 4
ttt_1=kron(ones(osz-1,1),c_omegas(1:end-1));
sss_1=ttt_1-ttt_1'+diag(ones(osz-1,1));
gammas_1=1./prod(sss_1,1);
PxGamma=P_omegas(1:end-1).*gammas_1;

ww=linspace(0,pi,16*L);
c_ww=cos(ww);
wsz=length(c_ww);
ttt_ww=kron(ones(wsz,1),c_omegas(1:end-1));
rrr=kron(c_ww',ones(1,osz-1));
sss_ww=rrr-ttt_ww;
ff_tot=prod(sss_ww,2);
fff=kron(ff_tot,ones(1,osz-1));
fff_int=fff./sss_ww;
yyy=fff_int*PxGamma';
yyy=yyy';
for ii = 2 : length(yyy)-1
    if isnan(yyy(ii))
        yyy(ii) = 0.5*(yyy(ii-1)+yyy(ii+1));
    end
end
%% plot
figure(1);
plot(ww,yyy);
hold on;
xlabel('frequency');
ylabel('magnitude');
scatter(omegas,P_omegas);
hold on;
scatter(2*pi/32:2*pi/32:32*pi/32,zeros(1,16),'k');
hold on;
% end

%% step 5
[w_max1,max_num1]=findpeaks1(ww,yyy);
[w_max2,max_num2]=findpeaks2(ww,yyy,epsilon);
omegas_1 = [w_max1,w_max2];
max_num = max_num1+max_num2;
num = 15+max_num;
% observe and pick new omegas
figure(2);
scatter(2*pi/32:2*pi/32:32*pi/32,zeros(1,16),'k');
hold on;
scatter(omegas_1,zeros(1,length(omegas_1)),'r');
hold on;