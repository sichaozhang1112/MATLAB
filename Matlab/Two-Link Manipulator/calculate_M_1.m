% Calculate M_1
M_1 = 0;
m_1 = 2;
I_1 = 3;
l_1 = 1.5;
l_c1 = 0.75;
m_2 = 1;
I_2 = 2;
l_2 = 1;
l_c2 = 0.5;
g = 9.81;

for q_1 = 1:2*pi/360:2*pi
    for q_2 = 1:2*pi/360:2*pi
        g_11 = -(m_1 * l_c1 + m_2 * l_1) * g * sin(q_1) - m_2 * l_c2 * g * sin(q_1 + q_2);
        g_12 = - m_2 * l_c2 * g * sin(q_1 + q_2);
        g_21 = - m_2 * l_c2 * g * sin(q_1 + q_2);
        g_22 = - m_2 * l_c2 * g * sin(q_1 + q_2);
        G = [g_11, g_12;
             g_21, g_22];
        if M_1 < norm(G)
            M_1 = norm(G);
        end
    end
end

       