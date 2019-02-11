sigma_1 = 6.9761;
sigma_2 = 10.5802;
Kc = 1.2333;
Kp = [100;100];
Kd = 0;
gamma_1 = 2 * sigma_2 / ((sigma_1 * Kp) ^ (0.5));
gamma_2 = Kd * Kd / (2 * Kp * Kd) + 4 * sigma_2 + Kc / (2 ^ 0.5);
gamma = max(gamma_1,gamma_2);
