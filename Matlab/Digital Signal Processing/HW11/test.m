w = -pi : 0.01 : pi;
h = 1 + 2*exp(-j*w) + 2*exp(-2*j*w) + 1*exp(-3*j*w);
h2 = 1 + 1*exp(-j*w) + 2*exp(-2*j*w) + 2*exp(-3*j*w) + 2*exp(-4*j*w) + 2*exp(-5*j*w) + 1*exp(-6*j*w) + 1*exp(-7*j*w);
r = sin(pi/2*w)./(pi/2*w);
x = (1+1/pi*w).*exp(-2*j*w);
t = exp(-2*j*w);
plot(w,r);

n = -100 : 100;
x = cos(9*pi/20*n);
y = ones(1,32);
z = conv(x,y);
plot(1:length(x),x)

gua = 5*sin(3*pi*n/2+pi/6) - 5*cos(3*pi*n/2-pi/3);
plot(gua)

w = pi/20;

sum = 1;
for ii = 1 : 31
    sum = exp(-j*ii*w);
end