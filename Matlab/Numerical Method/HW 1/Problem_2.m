%% error at the tip deflection

N = [10 : 10 : 2000];
h = 1./N;
N_len = length(N);

E = zeros(1,N_len);


for ii = 1:N_len
    % compute u_dot
    u_dot = zeros(N(ii)+1,1);
    u_dot(end,1) = 1;
    
    % compute A 
    A = getA(N(ii)+1,h(ii));
    
    % compute u
    u = inv(A)*u_dot;
    
    % add result
    error = abs((-1/3) - u(end,1));
    E(ii) = error;
end

figure();
loglog(h,E,'r','linewidth',2);
title('Error of Tip Deflection');
xlabel('Step Size');
ylabel('Error');
grid minor;
hold on;

%
%% L2 norm error

N = [10 : 10 : 2000];
h = 1./N;
N_len = length(N);

E = zeros(1,N_len);

for ii = 1:N_len
    % compute u_dot
    u_dot = zeros(N(ii)+1,1);
    u_dot(end,1) = 1;
    
    % compute A 
    A = getA(N(ii)+1,h(ii));
    
    % compute u
    u = inv(A)*u_dot;
    
    % calculate u_fact
    u_fact = zeros(N(ii)+1,1);
    for jj = 1:(N(ii)+1)
    u_fact(jj) = (1/6)*(h(ii)*(jj-1))^3 - (1/2)*(h(ii)*(jj-1))^2;
    end
    
    % add result
    error = norm(u_fact - u);
    E(ii) = error;
end

figure();
loglog(h,E,'b','linewidth',2);
title('L2 Norm Error');
xlabel('Step Size');
ylabel('L2 Norm Error');
grid minor;
hold on;

%
%% beam shape for finest solution

N = 2000;
h = 1./N;

% compute u_dot
u_dot = zeros(N+1,1);
u_dot(end,1) = 1;

% compute A 
A = getA(N+1,h);

% compute u
u = inv(A)*u_dot;

for xx = 1 : (N+1)
    x(xx) = h * (xx-1);
end

figure();
plot(x,u,'linewidth',2);
title('Beam Shape (h=1/2000)');
xlabel('Distance');
ylabel('Displacement');
grid minor;


