function x_dot = difeq_humangaitsimplified_cases(t,x,K_1,A_1,B_1)

    
x_dot = zeros(4,1);

% q_d = [pi/6;pi/6;0;0];

u_1 = K_1 * (- x); 
% u_2 = - K_2 * x; 
% u_3 = - K_3 * x; 
% u_4 = - K_4 * x; 

if x(1) >= x(2)
x_dot = A_1 * x + B_1 * u_1;
else
    x_dot = A_1 * x+ B_1 * [u_1(1);0];
end
 
% if x(1) == 0 %&& x(2) <= 0
%     x_dot = A_2 * x + B_2 * u_2;
% end
% 
% % if (x(1) < 0 || x(1) > 0) && x(2) == 0
% %     x_dot = A_3 * x + B_3 * u_3;
% % end
% 
% if x(1) < 0 %&& x(2) < 0
%     x_dot = A_4 * x + B_4 * u_4;
% end

end
