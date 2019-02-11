function x_dot = difeq_twolink(t,x,m_1,m_2,I_1,I_2,l_1,l_2,l_c1,l_c2,g,q_1d,q_2d,Kp,Kv)
x_dot = zeros(4,1);

% D(q) , C(q , q_dot) , G(q) , U
d_11 = m_1 * l_c2 * l_c2 + m_2 * (l_1 * l_1 + l_c2 * l_c2 + 2 * l_1 * l_c2 * cos(x(3))) + I_1 + I_2;
d_12 = m_2 * (l_c2 * l_c2 + l_1 * l_c2 * cos(x(3))) + I_2;
d_21 = m_2 * (l_c2 * l_c2 + l_1 * l_c2 * cos(x(3))) + I_2;
d_22 = I_2 + m_2 * l_c2 * l_c2;

c_11 = - m_2 * x(4) * l_1 * l_c2 * sin(x(3));
c_12 = - m_2 * (x(2) + x(4)) * l_1 * l_c2 * sin(x(3));
c_21 = m_2 * x(2) * l_1 * l_c2 * sin(x(3));
c_22 = 0;

g_1 = (m_1 * l_c1 + m_2 * l_1) * g * cos(x(1)) + m_2 * l_c2 * g * cos(x(1) + x(3));
g_2 = m_2 * l_c2 * g * cos(x(1) + x(3));

u_1 = Kp(1,1) * (q_1d - x(1)) + Kv(1,1) * (0 - x(2));
u_2 = Kp(2,2) * (q_2d - x(3)) + Kv(2,2) * (0 - x(4));

% x_dot
x_dot(1) = x(2);
x_dot(2) = ((u_1 - g_1 - c_11 * x(2) - c_12 * x(4)) * d_22 - (u_2 - g_2 - c_21 * x(2)) * d_12)/(d_11 * d_22 - d_21 * d_12);
x_dot(3) = x(4);
x_dot(4) = ((u_1 - g_1 - c_11 * x(2) - c_12 * x(4)) * d_21 - (u_2 - g_2 - c_21 * x(2)) * d_11)/(d_12 * d_21 - d_22 * d_11);

end

