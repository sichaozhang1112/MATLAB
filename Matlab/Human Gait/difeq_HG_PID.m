function x_dot = difeq_HG_PID(t,x,A,B,Kp,Kd,Ki)
x_dot = zeros(9,1);

% PID Control Law
u = zeros(3,1);
u = Kp * x(1:3) + Kd * x(4:6) + Ki * x(7:9);

x_dot(1:6) = A * x(1:6) + B * u;
x_dot(7:9) = x(1:3);
end
