A = [0,1,0,0;
    -10,-10,10,0;
    0,0,0,1;
    10,0,-10,-100];
B = [0,0,1,0;
    10,0,0,0;
    0,0,0,1;
    0,10,0,0];

Co = ctrb(A,B);
rank(Co);

Q = diag([100,0.1,100,0.1]);
R = 10*diag(ones(4,1));

K = lqr(A,B,Q,R);

[t,y] = ode45(@problem5,[0:0.01:1],zeros(4,1),[]);
plot(t,y,'linewidth',1.5);
xlabel('time');
ylabel('displacements');
legend('\theta_l','\theta_l dot','\theta_m','\theta_m dot');

function ydot = problem5(t,y)
A = [0,1,0,0;
    -10,-10,10,0;
    0,0,0,1;
    10,0,-10,-100];
B = [0,0,1,0;
    10,0,0,0;
    0,0,0,1;
    0,10,0,0];
Q = diag([100,0.1,100,0.1]);
R = 10*diag(ones(4,1));

K = lqr(A,B,Q,R);
y_d = [1;0;1;0];
ydot = A*y+B*K*(y_d-y);
end