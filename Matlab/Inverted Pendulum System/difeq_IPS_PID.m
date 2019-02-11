function z_dot = difeq_IPS_PID(t,z,A,B,Kp,Kd,Ki)
u = Kp*z(3) + Kd*z(4) + Ki*z(5);
z_dot = zeros(5,1);
z_dot(1:4) = A*z(1:4) + B*u;
z_dot(5) = z(3);
end

