%% L2 norm error

% step size h
J = [10,50,100,250,500,1000];
h = 1 ./ J;
% time step size dt
N = 20000;
dt = 20 ./ N;

E = zeros(1,length(J));
for ii = 1 : length(J)
    % wave matrix U
    U_1 = getU( J(ii),N );
    % U_2 has half step size of U_1
    U_2 = getU( J(ii)*2,N );
    
    % decrease the size of U_2 to the same as U_1
    U_3 = zeros(J(ii)+1,1);
    for nn = 1 : (N+1)
        for kk = 1 : (J(ii)+1)
           U_3(kk,nn) = U_2(2*kk-1,nn);
        end
    end
 
    E(ii) = norm(U_3-U_1);
end

figure();
plot(h,E,'linewidth',1.5);
title('L2 Norm Error of Wave Equation');
xlabel('Step Size');
ylabel('L2 norm error');
grid minor;


%% wave surface
% step size h
J = 1000;
h = 1 ./ J;
% time step size dt
N = 20000;
dt = 20 ./ N;

% wave matrix U
U = getU( J,N );

for xx = 1 : (J+1)
  x(xx) = (1/J) * (xx-1);
end

for tt = 1 : (N+1)
  t(tt) = (20/N) * (tt-1);
end

figure();
mesh(t,x,U);
title('Wave Surface (h=1/1000)');
xlabel('Time');
ylabel('Distance');
zlabel('Wave Surface');










