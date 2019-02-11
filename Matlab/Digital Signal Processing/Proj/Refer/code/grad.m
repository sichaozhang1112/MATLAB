N = 143

omegas = linspace(0,pi,N);

% omegas=[0    0.3001    0.5601    0.2*pi    1.5080    1.8601    2.2101 2.5701 pi];

% osz=length(omegas);
% D_omegas=(omegas<=(1/32*pi));

for ii = 1:3
    if (ii >1)
        omegas = new_ww;
    end
    
    osz=length(omegas);
    D_omegas=(omegas<=(1/32*pi));
    
    epsilon = getEpsilon(omegas,D_omegas);

    alternating = (-1).^[0:length(omegas)-1];
    p_omegas = epsilon.*alternating + D_omegas;

    %% Lagrange interpolation
    omegas_L = omegas(2:end);
    p_omegas_L = p_omegas(2:end);
    ww=[0.0001:.001:pi];
    yyy = lagrange_interp(omegas_L,p_omegas_L,ww);
%     yyy = linear_interp(yyy);
    %plot
    figure();
    plot(ww,yyy);

    %% find new w_i for next iteration
    D_ww = ww<=(1/32*pi);
    %figure(2);
    diff = yyy'-D_ww;
    %plot(ww,abs(diff));
    
    new_ww = findExtremal(abs(diff),ww);
    www = new_ww;
    if(length(new_ww) == N-2)
        new_ww = sort([0 new_ww pi]);
    end
    
end
