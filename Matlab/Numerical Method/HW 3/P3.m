%
%% MECH 505-Homework 3
%% Sichao Zhang
%
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
%%
for ii = 1 : length(x)
    for jj = 1 : length(y)
        func(ii,jj) = f(x(ii),y(jj));
    end
end
global_max = max(max(func));
figure(1);
mesh(x,y,func);
hold on;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('function: exp(-1/(2^x^2)).*exp(-1/(2^y^2))*sin(2*pi*x)*cos(pi*y)');

clear ii jj;
%
%% Random Search
opt_f = [];
cnt = [];
for ii = 1 : 1e3
    new_x(:,ii) = rand(1)*10-5;
    new_y(:,ii) = rand(1)*10-5;
    new_f(:,ii) = f(new_x(:,ii),new_y(:,ii));
    if ii > 1
        if new_f(:,ii) > opt_f(end)
            opt_f = [opt_f,new_f(:,ii)];
            opt_x = [opt_x,new_x(:,ii)];
            opt_y = [opt_y,new_y(:,ii)];
            cnt = [cnt,ii];
        else
            opt_f = [opt_f,opt_f(:,ii-1)];
            opt_x = [opt_x,opt_x(:,ii-1)];
            opt_y = [opt_y,opt_y(:,ii-1)];
            cnt = [cnt,ii];
        end
    else
        opt_x = new_x(:,ii);
        opt_y = new_y(:,ii);
        opt_f = new_f(:,ii);
        cnt = ii;
    end
end

rand_max = opt_f(end);
rand_relerr = (1-opt_f)/1 *100;
rand_minrelerr = rand_relerr(end);

rand_search(1,:) = cnt;
rand_search(2,:) = opt_f;
rand_search(3,:) = rand_relerr;

figure(2);
plot(rand_search(1,:),rand_search(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Random Search');

clear new_f new_x new_y opt_x opt_y ii cnt rand_relerr opt_f;
%
%% Latin Hyper Cube Sampling
% pick 1e3 * 1e3 coordinates
l_x = -5 : 0.01 : 5;
l_y = -5 : 0.01 : 5;
len_x = length(x);
len_y = length(y);
cord = zeros(len_x,len_y);
for ii = 1 : 1e3
    latin_x(:,ii) = unidrnd(len_x);
    latin_y(:,ii) = unidrnd(len_y);
    cord(latin_x(:,ii),latin_y(:,ii))=1;
    while cord(latin_x(:,ii),latin_y(:,ii)) == 0
        latin_x(:,ii) = unidrnd(len_x);
        latin_y(:,ii) = unidrnd(len_y);
        cord(latin_x(:,ii),latin_y(:,ii))=1;
    end
    new_x(:,ii) = -5+0.01*(latin_x(:,ii)-1);
    new_y(:,ii) = -5+0.01*(latin_y(:,ii)-1);
    new_f(:,ii) = f(new_x(:,ii),new_y(:,ii));
end

% find max
opt_x = new_x(:,1);
opt_y = new_y(:,1);
optlatin_f = new_f(:,1);
cnt = 1;

for ii = 2 : 1e3
    if new_f(:,ii)>optlatin_f(end)
        optlatin_f = [optlatin_f,new_f(:,ii)];
        opt_x = [opt_x,new_x(:,ii)];
        opt_y = [opt_y,new_y(:,ii)];
        cnt = [cnt,ii];
    else
        optlatin_f = [optlatin_f,optlatin_f(:,ii-1)];
        opt_x = [opt_x,opt_x(:,ii-1)];
        opt_y = [opt_y,opt_y(:,ii-1)];
        cnt = [cnt,ii];
    end
end

latin_max = optlatin_f(end);
latin_relerr = (1-optlatin_f)/1 *100;
Latin_minrelerr = latin_relerr(end);

latin_hyper(1,:) = cnt;
latin_hyper(2,:) = optlatin_f;
latin_hyper(3,:) = latin_relerr;

figure(3);
plot(latin_hyper(1,:),latin_hyper(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Latin Hyper Cube Sampling');

clear l_x l_y latin_x latin_y new_x new_y new_f opt_x opt_y ii cnt cord latin_relerr latin_x latin_y len_x len_y optlatin_f;
%
%% Univariate Search

uni_x(:,1) = 0;
uni_y(:,1) = 0;
uni_f(:,1) = f(uni_x(:,1),uni_y(:,1));

opt_f(:,1) = uni_f(:,1);
for ii = 1 : 1000
    mode = mod(ii,2);
    if mode == 0
        trange = [uni_x(ii),5];
    elseif mode == 1
        trange = [uni_y(ii),5];
    end
    [uni_x(:,ii+1),uni_y(:,ii+1),uni_f(:,ii+1)] = uni_quad(f,uni_x(:,ii),uni_y(:,ii),trange,mode);
    if uni_f(:,ii+1)>opt_f(:,ii)
        opt_f(:,ii+1) = uni_f(:,ii+1);
    else
        opt_f(:,ii+1) = opt_f(:,ii);
    end
end

uni_max = opt_f(end);
uni_relerr = (1-opt_f)/1 *100;
uni_minrelerr = uni_relerr(end);

uni_search(1,:) = 1:length(opt_f);
uni_search(2,:) = opt_f;
uni_search(3,:) = uni_relerr;

figure(4);
plot(uni_search(1,:),uni_search(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Univariate Search');

clear ii mode opt_f trange uni_f uni_relerr uni_x uni_y;
%
%% Newton's Method (Start from (0,0))
q(:,1) = [0;0];
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

newton0_max = opt_f(end);
newton0_relerr = (1-opt_f)/1 *100;
newton0_minrelerr = newton0_relerr(end);

newton0(1,:) = 1:length(opt_f);
newton0(2,:) = opt_f;
newton0(3,:) = newton0_relerr;

figure(5);
plot(newton0(1,:),newton0(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Newtons Method (Start from (0,0))');

clear df H newton0_relerr opt_f q ii;

%
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

figure(6);
plot(newton1(1,:),newton1(3,:));
grid on;
xlabel('iterarion number');
ylabel('relative error (%)');
title('Percent Error for Newtons Method (Start from (0.1,0.1))');

clear df H newton1_relerr opt_f q ii;
%
%%
figure(7);
plot(rand_search(1,:),rand_search(3,:));
hold on;
plot(latin_hyper(1,:),latin_hyper(3,:));
hold on;
plot(uni_search(1,:),uni_search(3,:));
hold on;
plot(newton0(1,:),newton0(3,:));
hold on;
plot(newton1(1,:),newton1(3,:));
hold on;
grid on;
legend('random search','latin hyper cube','univariate search','newtons method (0,0)','newtons method (0.1,0.1)');
xlabel('iterarion number');
ylabel('relative error (%)');
title('Compare of Four Methods');

