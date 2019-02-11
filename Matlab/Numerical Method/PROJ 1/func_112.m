%
%% MECH 505 - Project 1
%% Sichao Zhang
%
%% Second Derivative Function 

function [ d2f ] = func_112( func,x )

f = (func(x-(1/100)) - 2*func(x) +func(x+(1/100)))/((1/100)^2);
f = abs(f);

if f > 1e9
    h = 1e-5;
elseif (1e2 < f) && (f <= 1e9)
    h = f^(-1/3)*1e-2;
elseif (1e0 < f) && (f <= 1e2)
    h = f^(-1/2)*1e-1;
else
    h = 1e-1;
end

% 8th order accuracy central difference
d2f = ((-1/560)*func(x-4*h) + (8/315)*func(x-3*h) + (-1/5)*func(x-2*h) + (8/5)*func(x-h) + (-205/72)*func(x) + (8/5)*func(x+h) + (-1/5)*func(x+2*h) + (8/315)*func(x+3*h) + (-1/560)*func(x+4*h)) / (h^2);

end
