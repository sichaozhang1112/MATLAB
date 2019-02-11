function x_dot = difeq_HG_FSF(t,x,K,A,B)
x_dot = zeros(6,1);

% Full State Feedback Control Law
u = - K * x;

x_dot = A * x + B * u;
end

