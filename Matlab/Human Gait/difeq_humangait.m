function x_dot = difeq_humangait(t,x,B,C,A,m_f,I_f,alpha,beta,gamma,D,E,m_s,I_s,F,G,m_t,I_t,H,m_h,I_h,W_m,S_k,f,g,S)

x_dot = zeros(14,1);

% Constants c_ij for phase 1
c = zeros(7,7);
c(1,1) = m_f * C * C + I_f + (m_s + m_t) * B * B;
c(1,2) = m_s * D *B + m_t * (D + E) * B;
c(1,3) = m_t * F * B;
c(2,2) = I_s + m_s * D * D + m_t * (D + E) * (D + E);
c(2,3) = m_t * F * (D + E);
c(3,3) = I_t + m_t * F * F;
c(4,4) = I_h + m_h * H * H;
c(4,5) = m_h * H * (F + G);
c(4,6) = m_h * H * (D + E);
c(4,7) = 2 * m_h * H * A;
c(5,5) = I_t + m_t * F * F + m_h * (F + G) * (F + G);
c(5,6) = m_t * F * (D + E) + m_h * (D + E) * (F + G);
c(5,7) = 2 * m_t * F * A + 2 * m_h * A * (F + G);
c(6,6) = I_s + m_s * D * D + (m_h + m_t) * (D + E) * (D + E);
c(6,7) = 2 * (m_h + m_t) * (D + E) * A + 2 * m_s * A * D;
c(7,7) = I_f + (0.25 * m_f + m_h + m_t + m_s) * 4 * A * A;

a = zeros(7,7);
 for i = 1 : 7
    for j = 1 : 7
        a(i, j) = c(i, j) * cos(x(2 * i - 1)- x(2 * j - 1));
    end
 end

 M_ra = - 70 * x(1) - 70 * x(2);
 M_rk = 0; 
 M_rh = 0;
 M_la = 0;
 M_lk = 0;
 M_lh = 0;
 
 % d_i
 d_1 = B;
 d_2 = D + E;
 d_3 = F + G;
 d_4 = 0;
 d_5 = -(F + G);
 d_6 = -(D + E);
 d_7 = - 2 * A;
 d = [d_1; d_2; d_3; d_4; d_5; d_6; d_7];
 
 % R_i
 R_1 = - m_f * g * C * cos(x(1) - beta + gamma) - (m_s + m_t) * g * B * cos(x(1)) + M_ra + d(1);
 R_2 = - c(2, 1) * g * cos(x(3)) + M_rk - M_ra + d(2);  
 R_3 = - c(3, 1) * g * cos(x(5)) + M_rh - M_rk + d(3);
 R_4 = - m_h * H * g * cos(x(7)) - M_rh - M_lh + d(4);
 R_5 = - (m_h * (F + G) + m_t * F) * g * cos(x(9)) + M_lh - M_lk + d(5);
 R_6 = - ((m_h + m_t) * (D + E) + m_s * D) * g * cos(x(11)) + M_lk - M_la + d(6);
 R_7 = - (2 * A * (m_h + m_t + m_s) + A * m_f) * g * cos(x(13)) + M_la + d(7); 
 R = [R_1;R_2;R_3;R_4;R_5;R_6;R_7];
 
 % b_i
 sum_1 = 0;
 sum_2 = 0;
 b = zeros(7,1);
 for i = 1 : 7
     for j = 1 : 7
         sum_1 = sum_1 + c(i, j) * x(2 * j) * x(2 * j) * sin(x(2 * i -1) - x(2 * j -1));
         sum_2 = sum_2 + d(i) * d(j) * sin(x(2 * i -1) - x(2 * j -1)) + d(i) * S * sin(x(2 * i -1));
     end
     b(i) = - sum_1 + S_k * sum_2 + R(i);
 end
 
 gua = inv(a) * b;

x_dot(1) = x(2);
x_dot(2) = gua(1);
x_dot(3) = x(4);
x_dot(4) = gua(2);
% x_dot(5) = x(6);
% x_dot(6) = gua(3);
% x_dot(7) = x(8);
% x_dot(8) = gua(4);
% x_dot(9) = x(10);
% x_dot(10) = gua(5);
% x_dot(11) = x(12);
% x_dot(12) = gua(6);
% x_dot(13) = x(14);
% x_dot(14) = gua(7);

end