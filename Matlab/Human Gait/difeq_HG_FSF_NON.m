function x_dot = difeq_HG_FSF_NON(t,x,K,m_1,l_1,l_c1,I_1,m_2,l_2,l_c2,I_2,m_3,l_c3,I_3,g)
x_dot = zeros(6,1);

% Full State Feedback Control Law
u = - K * x;

% D , C , G
D = zeros(3,3);
D(1,1) = I_1 + m_1 * l_c1 * l_c1 + m_2 * l_1 * l_1 + m_3 * l_1 * l_1 ;
D(1,2) = (m_2 * l_1 * l_c2 + m_3 * l_1 * l_2 ) * cos(x(2) - x(1));
D(1,3) = m_3 * l_1 * l_c3 * cos(x(3) - x(1));
D(2,1) = (m_2 * l_1 * l_c2 + m_3 * l_1 * l_2) * cos(x(2) - x(1));
D(2,2) = I_2 + m_2 * l_c2 * l_c2 + m_3 * l_2 * l_2;
D(2,3) = m_3 * l_2 * l_c3 * cos(x(3) - x(2));
D(3,1) = m_3 * l_1 * l_c3 * cos(x(3) - x(1));
D(3,2) = m_3 * l_2 * l_c3 * cos(x(3) - x(2));
D(3,3) = I_3 + m_3 * l_c3 * l_c3;

C = zeros(3,3);
C(1,1) = 0;
C(1,2) = -(m_2 * l_1 * l_c2 + m_3 * l_1 * l_2) * sin(x(2) - x(1)) * x(5);
C(1,3) = - m_3 * l_1 * l_c3 * sin(x(3) - x(1)) * x(6);
C(2,1) = (m_2 * l_1 * l_c2 + m_3 * l_1 *l_2) * sin(x(2) - x(1)) * x(4);
C(2,2) = 0;
C(2,3) = - m_3 * l_2 * l_c3 * sin(x(3) - x(2)) * x(6);
C(3,1) = m_3 * l_1 * l_c3 * sin(x(3) - x(1)) * x(4);
C(3,2) = m_3 * l_2 * l_c3 * sin(x(3) - x(2)) * x(5);
C(3,3) = 0;

G = zeros(3,1);
G(1,1) = - (m_1 * g * l_c1 + m_2 * g * l_1 + m_3 * g * l_1) * sin(x(1));
G(2,1) = - (m_2 * g * l_c2 + m_3 * g * l_2) * sin(x(2));
G(3,1) = - (m_3 * g * l_c3) * sin(x(3));

x_dot(1:3) = x(4:6);
x_dot(4:6) = inv(D) * (u - C * x(4:6) - G);

end
