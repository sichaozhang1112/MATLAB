% Calculate sigma_1 and sigma_2
sigma_1 = 10;
sigma_2 = 0;
m_1 = 2;
I_1 = 3;
l_1 = 1.5;
l_c1 = 0.75;
m_2 = 1;
I_2 = 2;
l_2 = 1;
l_c2 = 0.5;
g = 9.81;

for q_2 = 1:2*pi/360:2*pi
        d_11 = m_1 * l_c2 * l_c2 + m_2 * (l_1 * l_1 + l_c2 * l_c2 + 2 * l_1 * l_c2 * cos(q_2)) + I_1 + I_2;
        d_12 = m_2 * (l_c2 * l_c2 + l_1 * l_c2 * cos(q_2)) + I_2;
        d_21 = m_2 * (l_c2 * l_c2 + l_1 * l_c2 * cos(q_2)) + I_2;
        d_22 = I_2 + m_2 * l_c2 * l_c2;
        D = [d_11,d_12;
             d_21,d_22];
        if sigma_2 < norm(D)
            sigma_2 = norm(D);
        end
        if sigma_1 > norm(D)
            sigma_1 = norm(D);
        end
end