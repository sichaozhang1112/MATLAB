options.maxIter = 10000 ;
options.display = 1 ;

func = @(x) exp(-1*(x(1)).^2).*cos(pi*(x(1)))-pi/2.*exp(-2*(x(2)).^2).*sin(2*pi*x(2)) ; ;
bounds = [-10 10; -10 10] ; 

% func = @(x) sin(10*x)/x;
% bounds = [-10,10];
func = @(x) sin(10*x(1))/x(1)+sin(20*x(2))/x(2)+sin(30*x(3))/x(3);
bounds = [-10,10;-10,10;-10,10];
% n = 1 : 50;

tic
[ x_opt,x_val ] = max_112( func,bounds,options );
toc
% figure(1);
% plot(n,time);
% hold on;
% figure(2);
% plot(n,error);
% hold on;

%%
% figure(1);
% legend('10','50','100');
% figure(2);
% legend('10','50','100');

% fprintf(['' num2str(iter) '\n']);

% tic
% [ x_opt,x_val,iter ] = compare( func,bounds,options );
% toc
% 
% fprintf(['' num2str(iter) '\n']);












