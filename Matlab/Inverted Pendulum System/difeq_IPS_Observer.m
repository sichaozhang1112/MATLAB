function z_dot = difeq_IPS_Observer(t,z,A_bar)
z_dot = zeros(8,1);
for i = 1:8
z_dot(i) = A_bar(i,:) * z;
end

