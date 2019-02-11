%% Problem 3
x = -5 : 0.01 : 5;
y = -5 : 0.01 : 5;
f = @(x,y) exp(-1./(2.^(x.^2))).*exp(-1./(2.^(y.^2))).*sin(2.*pi.*x).*cos(pi.*y); 
fx = @(x,y) 2*pi*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(2.*pi.*x).*cos(pi.*y) ...
    + 2./2.^(x.^2).*x.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2))*log(2).*cos(pi*y).*sin(2*pi*x);
fy = @(x,y) 2./2.^(y.^2).*y.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2))*log(2).*cos(pi*y).*sin(2*pi*x) ...
    - pi*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*sin(2*pi*x).*sin(pi*y);
fxx = @(x,y) (6243314768165359./2.^(x.^2).*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(pi.*y).*sin(2.*pi.*x))./4503599627370496 ...
    - 4.*pi.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(pi.*y).*sin(2.*pi.*x) ...
    - (6243314768165359./2.^(x.^2).*x.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi.*y).*sin(2.*pi.*x))./2251799813685248 ...
    + (6243314768165359./2.^(2.*x.^2).*x.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi.*y).*sin(2.*pi.*x))./2251799813685248 ...
    + (6243314768165359./2.^(x.^2).*x.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(2.*pi.*x).*cos(pi.*y))./2251799813685248 ...
    + 4./2.^(x.^2).*x.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(2.*pi.*x).*cos(pi.*y);
fyy = @(x,y) (6243314768165359./2.^(y.^2).*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(pi.*y).*sin(2.*pi.*x))./4503599627370496 ...
    - pi.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(pi.*y).*sin(2.*pi.*x) ...
    - (6243314768165359./2.^(y.^2).*y.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi.*y).*sin(2.*pi.*x))./2251799813685248 ...
    + (6243314768165359./2.^(2.*y.^2).*y.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi*y).*sin(2.*pi.*x))./2251799813685248 ...
    - (6243314768165359./2.^(y.^2).*y.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*sin(2.*pi.*x).*sin(pi.*y))./4503599627370496 ...
    - 2./2.^(y.^2).*y.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*sin(2.*pi.*x).*sin(pi.*y);
fxy = @(x,y) 4./2.^(y.^2).*y.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(2.*pi.*x).*cos(pi.*y) ...
    - (6243314768165359./2.^(x.^2).*x.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*sin(2.*pi.*x).*sin(pi.*y))./4503599627370496 ...
    - 2.*pi.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(2.*pi.*x).*sin(pi.*y) ...
    + (6243314768165359./2.^(x.^2)./2.^(y.^2).*x.*y.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi.*y).*sin(2.*pi.*x))./2251799813685248;
fyx = @(x,y) (6243314768165359./2.^(y.^2).*y.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(2.*pi.*x).*cos(pi.*y))./2251799813685248 ...
    - 2.*pi.^2.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*cos(2.*pi.*x).*sin(pi.*y) ...
    - 2./2.^(x.^2).*x.*pi.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*sin(2.*pi.*x).*sin(pi.*y) ...
    + (6243314768165359./2.^(x.^2)./2.^(y.^2).*x.*y.*exp(-1./2.^(x.^2)).*exp(-1./2.^(y.^2)).*log(2).*cos(pi.*y).*sin(2.*pi.*x))./2251799813685248;
%% Newton's Method (Start from (0.1,0.1))
q(:,1) = [0.1;0.1];
df = @(x,y) [fx(x,y);fy(x,y)];
H = @(x,y) [fxx(x,y),fxy(x,y);fyx(x,y),fyy(x,y)];
opt_f(:,1) = f(q(1,1),q(2,1));
for ii = 1 : 1000
    if df(q(1,ii),q(2,ii)) == 0
        break
    end
    q(:,ii+1) = q(:,ii) - H(q(1,ii),q(2,ii))\df(q(1,ii),q(2,ii));
    if f(q(1,ii+1),q(2,ii+1)) > opt_f(:,ii)
        opt_f(:,ii+1) = f(q(1,ii+1),q(2,ii+1));
    else
        opt_f(:,ii+1) = opt_f(:,ii);
    end
end

newton1_max = opt_f(end);
newton1_relerr = (1-opt_f)/1 *100;
newton1_minrelerr = newton1_relerr(end);

newton1(1,:) = 1:length(opt_f);
newton1(2,:) = opt_f;
newton1(3,:) = newton1_relerr;

figure(5);
plot(newton1(1,:),newton1(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Newtons Method (Start from (0.1,0.1))');

clear df H newton1_relerr opt_f q ii;
%







