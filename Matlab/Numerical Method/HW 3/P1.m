%
%% MECH 505-Homework 3
%% Sichao Zhang
%
%% Problem 1
%%
x = 0 : 0.001 : 1.5;
f = @(x) x.^8 - 1;
fdot = @(x) 8*x.^7;
true_zero = roots([1,0,0,0,0,0,0,0,-1]); 
figure(1);
plot(x,f(x));
hold on;
plot(x,zeros(1,length(x)));
hold on;
grid on;
xlabel('x');
ylabel('f(x)');
title('Function: f(x)=x^8-1');
scatter(1,0);
%
%% Bisection Method
x_l = x(1);
x_u = x(end);
bisec_zero = [];
for ii = 1 : 1000
    x_j(:,ii) = (x_l + x_u)/2;
    if f(x_l)*f(x_j(:,ii)) < 0
        x_u = x_j(:,ii);
    elseif f(x_l)*f(x_j(:,ii)) > 0
        x_l = x_j(:,ii);
    else
        bisec_zero = [bisec_zero,x_j(:,ii)];
        break
    end
end
bisec_relerr = (1-x_j)/1 *100;
bisec(1,:) = 1 : ii;
bisec(2,:) = x_j;
bisec(3,:) = bisec_relerr;
fprintf('Number of Iretations with Bisection Method: %5d\n',ii);
figure(2);
plot(bisec_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Bisection Method');

clear x_l x_u x_j bisec_relerr bisec_zero ii;
%
%% Linear Interpolation Method
x_l = x(1);
x_u = x(end);
inter_zero = [];
inter_tol = 1e-15;
for ii = 1 : 1000
    x_j(:,ii) = x_l - f(x_l)*(x_u-x_l)/(f(x_u)-f(x_l));
    if f(x_l)*f(x_j(:,ii))+inter_tol < 0
        x_u = x_j(:,ii);
    elseif f(x_l)*f(x_j(:,ii))-inter_tol > 0
        x_l = x_j(:,ii);
    else
        inter_zero = [inter_zero,x_j(:,ii)];
        break
    end
end
inter_relerr = (1-x_j)/1 *100;
inter(1,:) = 1 : ii;
inter(2,:) = x_j;
inter(3,:) = inter_relerr;
fprintf('Number of Iretations with Linear Interpolation Method: %5d\n',ii);
figure(3);
plot(inter_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Linear Interpolation Method');

clear x_l x_u x_j inter_relerr inter_zero inter_tol ii;
%
%% Newton-Raphson Method
% Start at the lower bound
x_l = x(1);
x_u = x(end);
x_j(:,1) = x_l;
newtonlow_zero = [];
newtonlow_tol = 1e-4;
for ii = 1 : 1000
    if fdot(x_j(:,ii)) == 0
        x_j(:,ii+1) = x_j(:,ii)+newtonlow_tol - f(x_j(:,ii)+newtonlow_tol)/fdot(x_j(:,ii)+newtonlow_tol);
    else
        x_j(:,ii+1) = x_j(:,ii) - f(x_j(:,ii))/fdot(x_j(:,ii));
    end
    if f(x_j(:,ii+1)) == 0
        newtonlow_zero = [newtonlow_zero,x_j(:,ii+1)];
        break
    end
end
newtonlow_relerr = (1-x_j)/1 *100;
newtonlow(1,:) = 0 : ii;
newtonlow(2,:) = x_j;
newtonlow(3,:) = newtonlow_relerr;
fprintf('Number of Iretations with Newton-Raphson Method(lower): %5d\n',ii);
figure(4);
plot(newtonlow_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Newton-Raphson Method(Lower Bound)');

clear x_l x_u x_j newtonlow_relerr newtonlow_zero newtonlow_tol ii;
%
% Start at the uppper bound
x_l = x(1);
x_u = x(end);
x_j(:,1) = x_u;
newtonup_zero = [];
newtonup_tol = 1e-4;
for ii = 1 : 1000
    if fdot(x_j(:,ii)) == 0
        x_j(:,ii+1) = x_j(:,ii)+newtonup_tol - f(x_j(:,ii)+newtonup_tol)/fdot(x_j(:,ii)+newtonup_tol);
    else
        x_j(:,ii+1) = x_j(:,ii) - f(x_j(:,ii))/fdot(x_j(:,ii));
    end
    if f(x_j(:,ii+1)) == 0
        newtonup_zero = [newtonup_zero,x_j(:,ii+1)];
        break
    end
end
newtonup_relerr = (1-x_j)/1 *100;
newtonup(1,:) = 0 : ii;
newtonup(2,:) = x_j;
newtonup(3,:) = newtonup_relerr;
fprintf('Number of Iretations with Newton-Raphson Method(upper): %5d\n',ii);
figure(5);
plot(newtonup_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Newton-Raphson Method(Upper Bound)');

clear x_l x_u x_j newtonup_relerr newtonup_zero newtonup_tol ii;
%
%% Secant Method
% Start at the lower bound
x_l = x(1);
x_u = x(end);
x_j(:,1) = x_u;
x_j(:,2) = x_l;
secant_zero = [];
secant_tol = 1e-4;
for ii = 1 : 1000
    if x_j(:,ii) == 0
        x_j(:,ii+2) = x_j(:,ii+1) - f(x_j(:,ii+1))*(x_j(:,ii)+secant_tol-x_j(:,ii+1))/(f(x_j(:,ii)+secant_tol)-f(x_j(:,ii+1)));
    elseif x_j(:,ii+1) == 0
        x_j(:,ii+2) = x_j(:,ii+1)+secant_tol - f(x_j(:,ii+1)+secant_tol)*(x_j(:,ii)-x_j(:,ii+1)-secant_tol)/(f(x_j(:,ii))-f(x_j(:,ii+1)+secant_tol));
    else
        x_j(:,ii+2) = x_j(:,ii+1) - f(x_j(:,ii+1))*(x_j(:,ii)-x_j(:,ii+1))/(f(x_j(:,ii))-f(x_j(:,ii+1)));
    end
    if f(x_j(:,ii+2)) == 0
        secant_zero = [secant_zero,x_j(:,ii+2)];
        break
    end
end
secant_relerr = (1-x_j)/1 *100;
secant(1,:) = -1 : ii;
secant(2,:) = secant_relerr;
secant(3,:) = x_j;
fprintf('Number of Iretations with Secant Method: %5d\n',ii);
figure(6);
plot(secant_relerr);
grid on;

clear x_l x_u x_j secant_relerr secant_zero secant_tol ii;
%
%%
figure(7);
plot(bisec(end,:));
hold on;
plot(inter(end,:));
hold on;
plot(newtonlow(end,:));
hold on;
plot(newtonup(end,:));
hold on;
grid on;
legend('bisection','linear interpolation','newton(lower)','newton(upper)');
xlabel('iretation number');
ylabel('relative error(%)');
title('Percent Error');