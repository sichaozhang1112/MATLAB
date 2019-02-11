function y_dot = difeq_IPS(t,y,K,A,B)
u = -K * y;
y_dot = zeros(4,1);
y_dot = A*y + B*u;
end

