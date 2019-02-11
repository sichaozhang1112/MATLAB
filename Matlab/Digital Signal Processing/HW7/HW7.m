%
%% ELEC 558 - Homework 7
%% Sichao Zhang
%
%% Problem 1
w = -pi : 0.00001 : pi;
Wa = @(w) exp(-15.5*j*w) .* sin(16*w) ./ sin(w/2);
% Wa
figure(1);
plot(w,mag2db(abs(Wa(w))));
axis([-pi,pi,-10,35]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
title('W_a(\omega)');

% Wa, worse case side lobe
sl_a = wcsl(Wa);

% Wb, K=1
K_b = 1;
Wb = @(w) K_b*(Wa(w-pi/32)*exp(-j*31*pi/64)+Wa(w+pi/32)*exp(j*31*pi/64));
figure(2);
plot(w,mag2db(abs(Wb(w))));
axis([-pi,pi,-60,40]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
title('W_b(\omega),K=1');

% Wb, K=0.7851
K_b = 0.7851;
Wb = @(w) K_b*(Wa(w-pi/32)*exp(-j*31*pi/64)+Wa(w+pi/32)*exp(j*31*pi/64));
figure(3);
plot(w,mag2db(abs(Wa(w))),'r');
hold on;
plot(w,mag2db(abs(Wb(w))),'b');
hold on;
axis([-pi,pi,-60,35]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
legend('W_a','W_b');
title('W_a(\omega),W_b(\omega)');

% Wb, K=0.7851, worse case side lobe
K_b = 0.7851;
Wb = @(w) K_b*(Wa(w-pi/32)*exp(-j*31*pi/64)+Wa(w+pi/32)*exp(j*31*pi/64));
sl_b = wcsl(Wb);

% wb, K=0.7851
n = 0 : 1 : 31;
wb = @(n) K_b*(exp(j*(2*pi/64)*(n-(31/2)))+exp(-j*(2*pi/64)*(n-(31/2))));
figure(4);
stem(n,wb(n));
xlabel('Time');
ylabel('Window');
title('w_b(n)');
%
%% Problem 2
% Wc, K=1
K_c = 1;
Wc = @(w) K_c*(0.5*(Wa(w-pi/16)*exp(-j*31*pi/32)+Wa(w+pi/16)*exp(j*31*pi/32))+Wa(w));
figure(5);
plot(w,mag2db(abs(Wa(w))),'r');
hold on;
plot(w,mag2db(abs(Wc(w))),'b');
hold on;
axis([-pi,pi,-60,35]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
title('W_a(\omega),W_c(\omega)');
legend('W_a','W_c');

% Wc, K=1, worse case side lobe
sl_c = wcsl(Wc);

% wc, K=1
wc = @(n) K_c*(1+0.5*(exp(j*(2*pi/32)*(n-(31/2)))+exp(-j*(2*pi/32)*(n-(31/2)))));
figure(6);
stem(n,wc(n));
xlabel('Time');
ylabel('Window');
title('w_c(n)');
%
%% Problem 3 - find beta
% find beta
for bb = 1 : 1 : 100
 beta = bb * 0.01;
 Wd = @(w) (beta*(Wa(w-pi/16)*exp(-j*31*pi/32)+Wa(w+pi/16)*exp(j*31*pi/32))+Wa(w));
 sl_d(bb) = wcsl(Wd);
end
%
%% Problem 3 
% Wd, K=1
beta = 0.01*find(sl_d==min(sl_d));
K_d = 1;
Wd = @(w) K_d*(beta*(Wa(w-pi/16)*exp(-j*31*pi/32)+Wa(w+pi/16)*exp(j*31*pi/32))+Wa(w));
figure(7);
plot(w,mag2db(abs(Wa(w))),'r');
hold on;
plot(w,mag2db(abs(Wd(w))),'b');
hold on;
axis([-pi,pi,-60,35]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
title('W_a(\omega),W_d(\omega)');
legend('W_a','W_d');


% Wd, K=1, worse case side lobe
sl_d = wcsl(Wd);

% wd, K=1
wd = @(n) K_d*(1+beta*(exp(j*(2*pi/32)*(n-(31/2)))+exp(-j*(2*pi/32)*(n-(31/2)))));
figure(8);
stem(n,wc(n),'r');
hold on;
stem(n,wd(n),'b');
hold on;
xlabel('Time');
ylabel('Window');
title('w_c(n),w_d(n)');
legend('w_c','w_d');
%
%% Problem 4 - find alpha
% find alpha 
for aa = 1 : 1 : 1000
 alpha = aa * 0.001;
 We = @(w) Wa(w-pi/32)*exp(-j*31*pi/64)+Wa(w+pi/32)*exp(j*31*pi/64)+alpha*(Wa(w-3*pi/32)*exp(-3*j*31*pi/64)+Wa(w+3*pi/32)*exp(j*3*31*pi/64));
 sl_e(aa) = wcsl(We);
end
%
%% Problem 4
% We, K=0.8592
alpha = 0.001*find(sl_e==min(sl_e));
K_e = 0.8592;
We = @(w) K_e*(Wa(w-pi/32)*exp(-j*31*pi/64)+Wa(w+pi/32)*exp(j*31*pi/64)+alpha*(Wa(w-3*pi/32)*exp(-3*j*31*pi/64)+Wa(w+3*pi/32)*exp(j*3*31*pi/64)));
figure(9);
plot(w,mag2db(abs(Wd(w))),'r');
hold on;
plot(w,mag2db(abs(We(w))),'b');
hold on;
axis([-pi,pi,-60,35]);
xlabel('Frequency(rad)');
ylabel('Magnitude(db)');
title('W_d(\omega),W_e(\omega)');
legend('W_d','W_e');

% We, K=0.8592, worse case side lobe
sl_e = wcsl(We);

% we, K=0.8592
we = @(n) K_e*((exp(j*(2*pi/64)*(n-(31/2)))+exp(-j*(2*pi/64)*(n-(31/2))))+alpha*(exp(j*(2*pi/64)*3*(n-(31/2)))+exp(-j*(2*pi/64)*3*(n-(31/2)))));
figure(10);
stem(n,wb(n),'r');
hold on;
stem(n,we(n),'b');
hold on;
xlabel('Time');
ylabel('Window');
title('w_b(n),w_e(n)');
legend('w_b','w_e');
%




