%% function getU

function [ U ] = getU( J,N )

% define U
U = zeros(J+1,N+1);
h = 1 / J;
dt = 20 / N;
U(:,1) = zeros(J+1,1);
U(:,2) = zeros(J+1,1);
U(end,2) = sin(dt);

M = getM(J+1,h,dt);

P = -1 * ones(J-1,1);
P = diag(P);
P = padarray(P,1)';

for nn = 3 : (N+1)
    U(2:(end-1),nn) = M * U(:,nn-1) + P * U(:,nn-2);
    U(1,nn) = 0;
    U(end,nn) = sin((nn-1)*dt);
end

end



