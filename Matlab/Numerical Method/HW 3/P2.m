%
%% MECH 505-Homework 3
%% Sichao Zhang
%
%% Problem 2
t = 0 : 0.001 : 1;
y = @(t) exp(-1./(2.^(t.^3))).*sin(pi*t);
ydot = @(t) (3 * log(2) * t.^2 .* (2.^(-t.^3))) .* sin(pi.*t) .* exp(-1./(2.^(t.^3))) + pi * cos(pi.*t) .* exp(-1./(2.^(t.^3)));
ydotdot = @(t) 3*log(2)*(t.^2.*(2.^(-t.^3)).*ydot(t)+(2*t.*(2.^(-t.^3))-3*log(2).*t.^4.*(2.^(-t.^3))).*y(t)) ...
               +exp(-1./(2.^(t.^3))).*(3*log(2)*t.^2.*(2.^(-t.^3)).*pi.*cos(pi*t)-pi^2*sin(pi*t));
figure(1);
plot(t,y(t));
grid on;
xlabel('t');
ylabel('y(t)');
title('function: exp(-1/(2^t^3))*sin(pi*t)');

% % find the true local maximum
% t_l = 0.1;
% t_u = t(end);
% bisec_zero = [];
% for ii = 1 : 1000
%     t_j(:,ii) = (t_l + t_u)/2;
%     if ydot(t_l)*ydot(t_j(:,ii)) < 0
%         t_u = t_j(:,ii);
%     elseif ydot(t_l)*ydot(t_j(:,ii)) > 0
%         t_l = t_j(:,ii);
%     else
%         bisec_zero = [bisec_zero,t_j(:,ii)];
%         break
%     end
% end
% t_max = t_j(end);
% 
% clear ii bisec_tol bisec_zero t_j t_l t_u;
% %
%% Golden Section Search
gold_rate = (sqrt(5)-1)/2;
t_a(:,1) = t(1);
t_b(:,1) = t(end);
gold_max = [];
for ii = 1 : 1000
    t_c(:,ii) = t_b(:,ii) - gold_rate * (t_b(:,ii) - t_a(:,ii));
    t_d(:,ii) = t_a(:,ii) + gold_rate * (t_b(:,ii) - t_a(:,ii));
    if t_c(:,ii) - t_d(:,ii) == 0
        t_m(:,ii) = t_c(:,ii);
        gold_max = [gold_max,t_c(:,ii)];
        break
    end
    if y(t_c(:,ii))>y(t_d(:,ii))
        t_a(:,ii+1) = t_a(:,ii);
        t_b(:,ii+1) = t_d(:,ii);
        t_m(:,ii) = t_c(:,ii);
    else
        t_a(:,ii+1) = t_c(:,ii);
        t_b(:,ii+1) = t_b(:,ii); 
        t_m(:,ii) = t_d(:,ii);
    end
end
gold_relerr = (gold_max-t_m)/gold_max *100;

gold(1,:) = 1 : ii;
gold(2,:) = t_a;
gold(3,:) = t_b;
gold(4,:) = t_c;
gold(5,:) = t_d;
gold(6,:) = t_m;
gold(7,:) = gold_relerr;
fprintf('Number of Iretations with Golden Section Search: %5d\n',ii);
figure(2);
plot(gold_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Golden Section Search');

clear t_a t_b t_c t_d t_m gold_rate gold_relerr;
%
%% Quadratic Interpolation
t_0(:,1) = t(1);
t_2(:,1) = t(end);
t_1(:,1) = 1/3 * (t(end)-t(1)) + t(1);
quad_tol = 1e-8;
quad_max = [];
for ii = 1 : 1000
    t_star(:,ii) = (y(t_0(:,ii))*(t_1(:,ii)^2-t_2(:,ii)^2)+y(t_1(:,ii))*(t_2(:,ii)^2-t_0(:,ii)^2)+y (t_2(:,ii))*(t_0(:,ii)^2-t_1(:,ii)^2))/(2*y(t_0(:,ii))*(t_1(:,ii)-t_2(:,ii))+2*y(t_1(:,ii))*(t_2(:,ii)-t_0(:,ii))+2*y(t_2(:,ii))*(t_0(:,ii)-t_1(:,ii)));
    if abs(t_1(:,ii) - t_star(:,ii)) < quad_tol
        t_m(:,ii) = t_1(:,ii);
        quad_max = [quad_max,t_1(:,ii)];
        break
    end
    if y(t_1(:,ii))>y(t_star(:,ii))
        t_0(:,ii+1) = t_0(:,ii);
        t_1(:,ii+1) = t_1(:,ii);
        t_2(:,ii+1) = t_star(:,ii);
        t_m(:,ii) = t_1(:,ii);
    else
        t_0(:,ii+1) = t_1(:,ii);
        t_1(:,ii+1) = t_star(:,ii);
        t_2(:,ii+1) = t_2(:,ii); 
        t_m(:,ii) = t_star(:,ii);
    end
end
quad_relerr = (quad_max-t_m)/quad_max *100;

quad(1,:) = 1 : ii;
quad(2,:) = t_0;
quad(3,:) = t_1;
quad(4,:) = t_star;
quad(5,:) = t_2;
quad(6,:) = t_m;
quad(7,:) = quad_relerr;
fprintf('Number of Iretations with Quadratic Interpolation: %5d\n',ii);
figure(3);
plot(quad_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Quadratic Interpolation');

clear t_0 t_1 t_2 t_star t_m quad_tol quad_relerr;
%
%% Newton's Method
t_n(:,1) = t(end);
newton_max = [];
for ii = 1 : 1000
    if ydot(t_n(:,ii)) == 0
        newton_max = [newton_max,t_n(:,ii)];
        break
    end
        t_n(:,ii+1) = t_n(:,ii) - ydot(t_n(:,ii))/ydotdot(t_n(:,ii));
end
newton_relerr = (newton_max-t_n)/newton_max *100;

newton(1,:) = 1 : ii;
newton(2,:) = t_n;
newton(3,:) = newton_relerr;
fprintf('Number of Iretations with Newtons Method: %5d\n',ii);
figure(4);
plot(newton_relerr);
grid on;
xlabel('iteration number');
ylabel('relative error(%)');
title('Percent Error for Newtons Method');

clear newton_relerr t_n;
%
%%
figure(5);
plot(gold(end,:));
hold on;
plot(quad(end,:));
hold on;
plot(newton(end,:));
hold on;
grid on;
legend('golden section','quadratic interplotion','newton');
xlabel('iretation number');
ylabel('relative error(%)');
title('Percent Error');