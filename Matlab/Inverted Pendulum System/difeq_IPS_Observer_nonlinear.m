function z_dot = difeq_IPS_Observer_nonlinear(t,z,m,M,g,l,K,L,C)
z_hat = z(1:4) - z(5:8);
u = -K * z_hat;
z_dot = zeros(8,1);
z_dot(1) = z(2);
z_dot(2) = (m*g*sin(z(3))*cos(z(3))-m*l*sin(z(3))*z(4)*z(4)-u)/(m*cos(z(3))*cos(z(3))-(m+M));
z_dot(3) = z(4);
z_dot(4) = (m*l*sin(z(3))*cos(z(3))*z(4)*z(4)-(m+M)*g*sin(z(3))+u*cos(z(3)))/(m*l*cos(z(3))*cos(z(3))-(m+M)*l);
z_dot(5) = z_dot(1)-z_hat(2);
z_dot(6) = z_dot(2)-(m*g*sin(z_hat(3))*cos(z_hat(3))-m*l*sin(z_hat(3))*z_hat(4)*z_hat(4)-u)/(m*cos(z_hat(3))*cos(z_hat(3))-(m+M));
z_dot(7) = z_dot(3)-z_hat(4);
z_dot(8) = z_dot(4)-(m*l*sin(z_hat(3))*cos(z_hat(3))*z_hat(4)*z_hat(4)-(m+M)*g*sin(z_hat(3))+u*cos(z_hat(3)))/(m*l*cos(z_hat(3))*cos(z_hat(3))-(m+M)*l);
z_dot = [z_dot(1:4);z_dot(5:8)-L*C*z(5:8)];
end