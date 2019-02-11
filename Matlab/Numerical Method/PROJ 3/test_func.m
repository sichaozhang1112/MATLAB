x = -10 : 0.01 : 10;
y = -10 : 0.01 : 10;

func = @(x) TwoD_MorletProblem(x) ;

for ii = 1 : length(x)
    for jj = 1 : length(y)
        f(ii,jj) = func([x(ii),y(jj)]);
    end
end

mesh(x,y,f)