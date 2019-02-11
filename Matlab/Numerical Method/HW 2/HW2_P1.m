%
%% MECH 505 - Homework 2
%% Sichao Zhang, S01276479
%
%% Problem 1
%% Function Definition
func = @(x) sinh(x);
Ifact = cosh(10)-cosh(0);
N = 1e3 : 1e3 : 1e6;
h = 10./ N;
%
%% The Trapezoidal Rule
for nn = 1 : length(N)
    x = [0:N(nn)]*(10/N(nn));
    f = func(x);
    
    Iest_tr(nn) = (10/(2*N(nn))) * (sum(f)*2 - func(1) - func(end));  
end

error_tr = abs(Ifact-Iest_tr);

figure(1);
loglog(h,error_tr);
xlabel('step size');
ylabel('absolute error');
title('Error of The Trapezoidal Rule');
%
%% Simpson's Midpoint Rule
N_smr = N*2;
h_smr = 10./N_smr;
for nn = 1 : length(N_smr)
    x_e = [0:N(nn)]*(10/N(nn));
    x_o = 10/N_smr(nn) + [0:(N(nn)-1)]*(10/N(nn));
    
    f_e = func(x_e);
    f_o = func(x_o);
    
    Iest_smr(nn) = h_smr(nn)*(4*sum(f_o) + 2*sum(f_e) - f_e(1) - f_e(end))/3;
end

error_smr = abs(Ifact-Iest_smr);

figure(2);
loglog(h_smr,error_smr);
xlabel('step size');
ylabel('absolute error');
title('Error of Simpsons Midpoint Rule');
figure(3);
loglog(h_smr,error_smr);
hold on;
%
%% Simpson's 3/8 Rule
N_str = N*3;
h_str = 10./N_str;
for nn = 1 : length(N_str)
    x_0 = [0:N(nn)]*(10/N(nn));
    x_1 = h_str(nn) + [0:(N(nn)-1)]*(10/N(nn));
    x_2 = 2*h_str(nn) + [0:(N(nn)-1)]*(10/N(nn));
    
    f_0 = func(x_0);
    f_1 = func(x_1);
    f_2 = func(x_2);
    
    Iest_str(nn) = 3 * h_str(nn) * (3*sum(f_1) + 3*sum(f_2) + 2*sum(f_0) - f_0(1) - f_0(end))/8;
end

error_str = abs(Ifact-Iest_str);

figure(4);
loglog(h_str,error_str);
xlabel('step size');
ylabel('absolute error');
title('Error of Simpsons 3/8 Rule');
figure(3);
loglog(h_str,error_str);
hold on;
xlabel('step size');
ylabel('absolute error');
title('Error of Simpsons Midpoint Rule and Simpsons 3/8 Rule');
legend('midpoint','3/8');
%
%% A 2 Point Gauss Quadrature 
for nn = 1 : length(N)
    x = [0:N(nn)]*(10/N(nn));
    
    x_1 = ((1/2)-(1/(2*sqrt(3))))*h(nn) + [0:(N(nn)-1)]*h(nn);
    x_2 = ((1/2)+(1/(2*sqrt(3))))*h(nn) + [0:(N(nn)-1)]*h(nn);
    
    f_1 = (h(nn)/2) * func(x_1);
    f_2 = (h(nn)/2) * func(x_2);
    
    Iest_2gq(nn) = sum(f_1) + sum(f_2);
end

error_2gq = abs(Ifact-Iest_2gq);

figure(5);
loglog(h,error_2gq);
xlabel('step size');
ylabel('absolute error');
title('Error of A 2 Point Gauss Quadrature');
figure(6);
loglog(h,error_2gq);
hold on;
%
%% A 4 Point Gauss-Legendre Quadrature 
x1 = sqrt((3/7)-(2/7)*sqrt(6/5));
x2 = sqrt((3/7)+(2/7)*sqrt(6/5));
w1 = (18+sqrt(30))/36;
w2 = (18-sqrt(30))/36;

for nn = 1 : length(N)
    x = [0:N(nn)]*(10/N(nn));
    
    x_1 = ((1/2)-(1/2)*x1)*h(nn) + [0:(N(nn)-1)]*h(nn);
    x_2 = ((1/2)+(1/2)*x1)*h(nn) + [0:(N(nn)-1)]*h(nn);
    x_3 = ((1/2)-(1/2)*x2)*h(nn) + [0:(N(nn)-1)]*h(nn);
    x_4 = ((1/2)+(1/2)*x2)*h(nn) + [0:(N(nn)-1)]*h(nn);
    
    f_1 = w1 * (h(nn)/2) * func(x_1);
    f_2 = w1 * (h(nn)/2) * func(x_2);
    f_3 = w2 * (h(nn)/2) * func(x_3);
    f_4 = w2 * (h(nn)/2) * func(x_4);
    
    Iest_4gq(nn) = sum(f_1) + sum(f_2) + sum(f_3) + sum(f_4);
end

error_4gq = abs(Ifact-Iest_4gq);

figure(7);
loglog(h,error_4gq);
xlabel('step size');
ylabel('absolute error');
title('Error of A 4 Point Gauss-Legendre Quadrature');
figure(6);
loglog(h,error_4gq);
hold on;
xlabel('step size');
ylabel('absolute error');
title('Error of A 2 and 4 Point Gauss-Legendre Quadrature');
legend('2 point','4 point');
%