%
%% MECH 505 - Project 1
%% Sichao Zhang
%
%% approach 1:  relationship between fact to h_m
func = @(x) tan(x);

for xx = 1 : 1000
    xval = 0.002*xx;
    fact(xx) = -12*sin(2*xval);
    h = logspace(-6,0,1000);
    est = ((-1/560)*func(xval-4*h) + (8/315)*func(xval-3*h) + (-1/5)*func(xval-2*h) + (8/5)*func(xval-h) + (-205/72)*func(xval) + (8/5)*func(xval+h) + (-1/5)*func(xval+2*h) + (8/315)*func(xval+3*h) + (-1/560)*func(xval+4*h)) ./ (h.^2);
    error = abs(fact(xx) - est);
    m = find(error==min(error));
    h_m(xx) = h(m(1));
end

loglog(fact,h_m,'linewidth',1.5);
hold on;
grid minor;
logfact = log10(fact);
loghm = log10(h_m);
% curve fitting