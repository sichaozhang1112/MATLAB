% Calculate Kc
Kc = 0;
m_1 = 2;
I_1 = 3;
l_1 = 1.5;
l_c1 = 0.75;
m_2 = 1;
I_2 = 2;
l_2 = 1;
l_c2 = 0.5;
g = 9.81;

for q_1dot = -10:1:10
    for q_2dot = -10:1:10
        for q_2 = 1:2*pi/360:2*pi
        c_11 = - m_2 * q_2dot * l_1 * l_c2 * sin(q_2);
        c_12 = - m_2 * (q_1dot + q_2dot) * l_1 * l_c2 * sin(q_2);
        c_21 = m_2 * q_1dot * l_1 * l_c2 * sin(q_2);
        c_22 = 0;
        C = [c_11,c_12;
             c_21,c_22];
        q_dot = [q_1dot;q_2dot];
         if Kc < (norm(C)/norm(q_dot))
            Kc = (norm(C)/norm(q_dot));
         end
        end
    end
end