%% function getM

function [ M ] = getM( M_len,h,dt )
% M_len : length of M
% h : step size
% dt : time step size

v = ones(1,M_len-2);

mat1 = ((dt^2)/(h^2)) * diag(v);
mat1 = padarray(mat1,2,'post')';

mat2 = (2-2*(dt^2)/(h^2)) * diag(v);
mat2 = padarray(mat2,1)';

mat3 = ((dt^2)/(h^2)) * diag(v);
mat3 = padarray(mat3,2,'pre')';

M = mat1 + mat2 + mat3;
end

