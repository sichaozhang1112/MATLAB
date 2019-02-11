function y_dot = difeq_IPS_nonlinear (t,y,m,M,g,l,K)
u = -K * y;
y_dot = zeros(4,1);
y_dot(1) = y(2);
y_dot(2) = (m*g*sin(y(3))*cos(y(3))-m*l*sin(y(3))*y(4)*y(4)-u)/(m*cos(y(3))*cos(y(3))-(m+M));
y_dot(3) = y(4);
y_dot(4) = (m*l*sin(y(3))*cos(y(3))*y(4)*y(4)-(m+M)*g*sin(y(3))+u*cos(y(3)))/(m*l*cos(y(3))*cos(y(3))-(m+M)*l);
end

