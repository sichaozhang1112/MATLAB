function [y, out] = Runge_Kutta(func, y, x0, h)
r_9 = 1.0 / 9.0;
r_2_9 = 2.0 / 9.0;
r_12 = 1.0 / 12.0;
r_324 = 1.0 / 324.0;
r_330 = 1.0 / 330.0;
r_28 = 1.0 / 28.0;

h29 = r_2_9 * h;
h9 = r_9 * h;

k1 = func(x0, y);
k2 = func(x0+h29, y + h29 * k1);
k3 = func(x0+3.0*h9, y + r_12 * h * (k1 + 3.0 * k2) );
k4 = func(x0+5.0*h9, y + r_324 * h * (55.0 * k1 - 75.0 * k2 + 200.0 * k3) );
k5 = func(x0+6.0*h9, y + r_330 * h * ( 83.0 * k1 - 195.0 * k2...
                                                  + 305.0 * k3 + 27.0 * k4) );
k6 = func(x0+h, y + r_28 * h * ( -19.0 * k1 + 63.0 * k2...
                                       + 4.0 * k3 - 108.0 * k4 + 88.0 * k5) );
k7 = func(x0+h, y + 0.0025 * h * ( 38.0 * k1 + 240.0 * k3 - 243.0 * k4...
                                                 + 330.0 * k5 + 35.0 * k6 ) );
y = y +  h * ( 0.0862 * k1 + 0.6660 * k3 - 0.7857 * k4...
                               + 0.9570 * k5 + 0.0965 * k6 - 0.0200 * k7 );

out = 0.0002 * (44.0 * k1 - 330.0 * k3 + 891.0 * k4 - 660.0 * k5...
                                                    - 45.0 * k6 + 100.0 * k7);

end