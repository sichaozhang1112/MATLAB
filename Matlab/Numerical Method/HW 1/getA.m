%% function getA

function [ A ] = getA( m, h )
%   m: the length of A

n = m - 4;
v = ones(1,n);

mat1 = 1/(h^4) * diag(v);
mat1 = padarray(mat1,4,'post')';

mat2 = -4/(h^4) * diag(v);
mat2 = padarray(mat2,3,'post');
mat2 = padarray(mat2,1,'pre')';

mat3 = 6/(h^4) * diag(v);
mat3 = padarray(mat3,2,'post');
mat3 = padarray(mat3,2,'pre')';

mat4 = -4/(h^4) * diag(v);
mat4 = padarray(mat4,1,'post');
mat4 = padarray(mat4,3,'pre')';

mat5 = 1/(h^4) * diag(v);
mat5 = padarray(mat5,4,'pre')';

mat = mat1 + mat2 + mat3 + mat4 + mat5;

mat = padarray(mat,2);

mat(1,1) = 1;
mat(2,1) = -1/h;
mat(2,2) = 1/h;
mat(end-1,end-2) = 1/(h^2);
mat(end-1,end-1) = -2/(h^2);
mat(end-1,end) = 1/(h^2);
mat(end,end-3) = -1/(h^3);
mat(end,end-2) = 3/(h^3);
mat(end,end-1) = -3/(h^3);
mat(end,end) = 1/(h^3);

A = mat;

end

