function [ time,displacements ] = Dormand_Prince( force, SysMat, trange, ICs, h )
f = @(t,y) SysMat*y + force(t,y);
t0 = trange(1);
t1 = trange(2);
dt = h; % time step
% dt = 1e-5;

c = [0,1/5,3/10,4/5,8/9,1,1];
a = [0,0,0,0,0,0,0;
     1/5,0,0,0,0,0,0;
     3/40,9/40,0,0,0,0,0;
     44/45,-56/15,32/9,0,0,0,0;
     19372/6561,-25360/2187,64448/6561,-212/729,0,0,0;
     9017/3168,-355/33,46732/5247,49/176,-5103/18656,0,0;
     35/384,0,500/1113,125/192,-2187/6784,11/84,0];
bz = [35/384,0,500/1113,125/192,-2187/6784,11/84,0];
bw = [5179/57600,0,7571/16695,393/640,-92097/339200,187/2100,1/40];
b = bz - bw;

% Absolute tolerance
abs_tol = 1e-9;
rel_tol = 1e-9;
alpha = 0.8;
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
    k7 = f(t + c(7) * dt, wi + a(7,1) * dt * k1 + a(7,2) * dt * k2 + a(7,3) * dt * k3 + a(7,4) * dt * k4 + a(7,5) * dt * k5 + a(7,6) * dt * k6);
    z = wi + dt * (bz(1) * k1 + bz(2) * k2 + bz(3) * k3 + bz(4) * k4 + bz(5) * k5 + bz(6) * k6 + bz(7) * k7);
    e = dt * norm(b(1) * k1 + b(2) * k2 + b(3) * k3 + b(4) * k4 + b(5) * k5 + b(6) * k6 + b(7) * k7);
    
    % Target tolerance for this step
    T = rel_tol * norm(wi) + abs_tol;
    if e <= T 
        t = t + dt;
        dt = alpha*dt*(T/e)^0.2;
        ii = ii + 1;
        tt(ii) = t;
        wi = z;
        y(ii,:) = z;
        k = 0;
    elseif k == 0 
        dt = alpha*dt*(T/e)^0.2;
        k = k + 1;
        lastit = 0;
    else 
        dt = dt / 2;
        lastit = 0;
    end
    
end

displacements = y;
time = tt;

end

