function x_dot = difeq_HG_OB(t,x,A_bar)
x_dot = zeros(12,1);

% Observer Control Law
for i = 1:12
    x_dot(i) = A_bar(i,:) * x;
end

