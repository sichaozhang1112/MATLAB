%
%% ELEC 558 - Homwork 4
%% Sichao Zhang
%
%% Problem a)

% import the sequence
load HW4_filt.mat;
imp = hw4_filt;

% roots of the polynomial of impulse response
z_roots = roots(imp);

% frequency response
fre = zeros(1000,1);

for k = 1 : 1000
  % 1000 values of complex variable z
  z_k = exp(j*2*pi*(k-1)/1000);
  % plug z_k into each of the factors of H(z_k)
  H_zk = imp(1)*prod(z_k - z_roots);
  % magnitude of the H(z_k)
  fre(k) = abs(H_zk);
end

plot(fre);
title('Frequency Response');
xlabel('Number');
ylabel('Frequency Response');

%
%% Problem b)

%% roots of polynomial H(z)
% import the sequence
load HW4_filt.mat;
imp = hw4_filt;

% roots of the polynomial of impulse response
z_roots = roots(imp);

scatter(real(z_roots),imag(z_roots));
hold on;

t = 0 : 0.01 : (2*pi);
xx = cos(t);
yy = sin(t);
plot(xx,yy);
hold on;
title('Roots of H(z)');

grid minor;

%
%% sort roots on the unit cycle and not
Cir = z_roots(10:35);
NonCir = z_roots([1:9,36:44]);
scatter(real(Cir),imag(Cir),'r');
hold on;
scatter(real(NonCir),imag(NonCir),'b');
hold on;
t = 0 : 0.01 : (2*pi);
xx = cos(t);
yy = sin(t);
plot(xx,yy);
hold on;
title('Roots of H(z)');

%
%% H1 and H2
Cir_Sin = Cir([1,3,4,7,8,11,12,15,16,19,20,23,24]);
NonCir_H1b = NonCir([2,3,6,7,13,14,17,18]);
NonCir_H2b = NonCir([1,4,5,8,9,10,11,12,15,16]);
H1b_roots = [Cir_Sin(:,1);NonCir_H1b(:,1)];
H2b_roots = [Cir_Sin(:,1);NonCir_H2b(:,1)];

% frequency response
fre1b = zeros(1000,1);
fre2b = zeros(1000,1);

C = imp(1);

% calculate A to minimize the error of fre1 and fre2
% error of fre1 and fre2
E = zeros(100,1);

for ii = 1 : 100
    A = ii * 0.001;
for k = 1 : 1000
  % 1000 values of complex variable z
  z_k = exp(j*2*pi*(k-1)/1000);
  % plug z_k into each of the factors of H1(z_k) and H2(z_k)
  H1b_zk = A * prod(z_k - H1b_roots);
  H2b_zk = (C/A) * prod(z_k - H2b_roots);
  % magnitude of the H1(z_k) and H2(z_k)
  fre1b(k) = abs(H1b_zk);
  fre2b(k) = abs(H2b_zk);
end
  E(ii) = norm(fre1b-fre2b);
end

figure();
plot(E,'linewidth',1.5);
xlabel('A*1000');
ylabel('L2 norm Error of fre1 and fre2');
title('L2 norm Error of fre1 and fre2');

% when A = 0.04, frequency response of H1 and H2
A = 0.04;
B = C/A;

for k = 1 : 1000
  % 1000 values of complex variable z
  z_k = exp(j*2*pi*(k-1)/1000);
  % plug z_k into each of the factors of H1(z_k) and H2(z_k)
  H1b_zk = A * prod(z_k - H1b_roots);
  H2b_zk = B * prod(z_k - H2b_roots);
  % magnitude of the H1(z_k) and H2(z_k)
  fre1b(k) = abs(H1b_zk);
  fre2b(k) = abs(H2b_zk);
end

figure();
plot(fre1b,'r');
hold on;
plot(fre2b,'b');
hold on;
legend('frequency response of H1','frequency response of H2');
xlabel('sample number');
ylabel('frequency respose');
title('frequency response of H1 and H2(A=0.04)');

%
%% impulse response of h1 and h2
h1b = A * poly(H1b_roots);
h2b = B * poly(H2b_roots);

%
%% Problem c)

%% H1 and H2
Cir_Sin = Cir([1,3,4,7,8,11,12,15,16,19,20,23,24]);
NonCir_H1c = NonCir([1,4,5,8,9,13,14,17,18]);
NonCir_H2c = NonCir([2,3,6,7,10,11,12,15,16]);
H1c_roots = [Cir_Sin(:,1);NonCir_H1c(:,1)];
H2c_roots = [Cir_Sin(:,1);NonCir_H2c(:,1)];

% frequency response
fre1c = zeros(1000,1);
fre2c = zeros(1000,1);

A = -0.0345;
B = 0.0503;

for k = 1 : 1000
  % 1000 values of complex variable z
  z_k = exp(j*2*pi*(k-1)/1000);
  % plug z_k into each of the factors of H1(z_k) and H2(z_k)
  H1c_zk = A * prod(z_k - H1c_roots);
  H2c_zk = B * prod(z_k - H2c_roots);
  % magnitude of the H1(z_k) and H2(z_k)
  fre1c(k) = abs(H1c_zk);
  fre2c(k) = abs(H2c_zk);
end

figure();
plot(fre1c,'r');
hold on;
plot(fre2c,'b');
hold on;
legend('frequency response of H1','frequency response of H2');
xlabel('sample number');
ylabel('frequency respose');
title('frequency response of H1 and H2(A=-0.0345)');

%
%% impulse response of h1 and h2

h1c = A * poly(H1c_roots);
h2c = B * poly(H2c_roots);
nn = 1 : 23;

% real part
figure();
plot(nn,real(h1c),'r');
hold on;
plot(nn,real(h2c),'b');
hold on;
title('Real Part of Sequence of h1 and h2');
legend('h1','h2');
xlabel('Number');
ylabel('real part of impulse response');

% imaginary part
figure();
plot(nn,imag(h1c),'r');
hold on;
plot(nn,imag(h2c),'b');
hold on;
title('Imaginary Part of Sequence of h1 and h2');
legend('h1','h2');
xlabel('Number');
ylabel('Imaginary part of impulse response');