function [ time,displacements ] = int_112( force, SysMat, trange, ICs )

f = @(t,y) SysMat*y + force(t,y);
t0 = trange(1);
t1 = trange(2);
% dt = h; % time step
dt = 8e-6;

c = [0,1/4,3/8,12/13,1,1/2];
a = [0,0,0,0,0,0;
     1/4,0,0,0,0,0;
     3/32,9/32,0,0,0,0;
     1932/2197,-7200/2197,7296/2197,0,0,0;
     439/216,-8,3680/513,-845/4104,0,0;
     -8/27,2,-3544/2565,1859/4104,-11/40,0];
bz = [16/135,0,6656/12825,28561/56430,-9/50,2/55];
bw = [25/216,0,1408/2565,2197/4104,-1/5,0];
b = bz - bw;

% Absolute tolerance
abs_tol = 1e-9;
rel_tol = 1e-9;
alpha = 0.84;
% Initial time moment
ii = 1;
tt(1) = t0;
t = t0;
% Initial condition
y(1,:) = ICs;
wi = ICs;
k = 0;

% while t < t1
lastit = 0;
while lastit == 0
    % Stretch the step if within 10% of b-t
    if t + 1.1*dt > t1
        dt = t1 - t;
        lastit = 1;
    end

    % Compute the step
    k1 = f(t + c(1) * dt,wi);
    k2 = f(t + c(2) * dt, wi + a(2,1) * dt * k1);
    k3 = f(t + c(3) * dt, wi + a(3,1) * dt * k1 + a(3,2) * dt * k2);
    k4 = f(t + c(4) * dt, wi + a(4,1) * dt * k1 + a(4,2) * dt * k2 + a(4,3) * dt * k3);
    k5 = f(t + c(5) * dt, wi + a(5,1) * dt * k1 + a(5,2) * dt * k2 + a(5,3) * dt * k3 + a(5,4) * dt * k4);
    k6 = f(t + c(6) * dt, wi + a(6,1) * dt * k1 + a(6,2) * dt * k2 + a(6,3) * dt * k3 + a(6,4) * dt * k4 + a(6,5) * dt * k5);
    z = wi + dt * (bz(1) * k1 + bz(2) * k2 + bz(3) * k3 + bz(4) * k4 + bz(5) * k5 + bz(6) * k6);
    e = dt * norm(b(1) * k1 + b(2) * k2 + b(3) * k3 + b(4) * k4 + b(5) * k5 + b(6) * k6);
    
    % Target tolerance for this step
    T = rel_tol * norm(wi) + abs_tol;
    if e <= T % In case the tolerance is met
        t = t + dt;
        dt = alpha*dt*(T/e)^0.2;
        ii = ii + 1;
        tt(ii) = t;
        wi = z;
        y(ii,:) = z;
        k = 0;
    elseif k == 0 % Tolerance is not met for the first time in this step
        dt = alpha*dt*(T/e)^0.2;
        k = k + 1;
        lastit = 0;
    else % Tolerance is not met more than once in this step
        dt = dt / 2;
        lastit = 0;
    end
end

displacements = y;
time = tt';

end
