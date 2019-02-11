function  x_dot = difeq_humangait_simplified(t,x,m_1,l_1,l_c1,I_1,m_2,l_2,l_c2,I_2,g,Kp,Kv)

x_dot = zeros(4,1);

c_1 = m_1 * l_c1 * l_c1 + m_2 * l_1 * l_1 + I_1;
c_2 = m_2 * l_1 * l_c2;
c_3 = m_2 * l_c2 * l_c2 + I_2;
c_4 = (m_1 * l_c1 + m_2 * l_1) * g;
c_5 = m_2 * l_c2 * g;

% M,C,G
M = [c_1,c_2 * cos(x(1) - x(2));
     c_2 * cos(x(1) - x(2)),c_3];
C = [0,c_2 * sin(x(1) - x(2)) * x(4);
     - c_2 * sin(x(1) - x(2)) * x(3),0];
G = [- c_4 * sin(x(1)); - c_5 * sin(x(2))];

q_d = [pi/6;pi/3];
q_ddot = [0;0];

U = Kp * (q_d - x(1:2)) + (q_ddot - Kv * x(3:4));

x_dot(1:2) = x(3:4);
x_dot(3:4) = inv(M) * (U - C * x(3:4) - G);

end
