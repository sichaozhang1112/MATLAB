function x_dot = difeq_test(t,x,K_1,A_1,B_1)
    
x_dot = zeros(4,1);

u_1 = - K_1 * x; 

x_dot = A_1 * x + B_1 * u_1;

end