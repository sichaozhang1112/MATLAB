function [ x_opt,x_val ] = minsearch( func,bounds,options )

% Nelder_Mead
fun =@(x) -func(x);
maxIter = options.maxIter;
display = options.display;
dim_num = size(bounds,1);
ver_num = dim_num+1;
x = zeros(dim_num,ver_num);
usual_delta = 0.05;             % 5 percent deltas for non-zero terms
zero_term_delta = 0.00025;      % Even smaller delta for zero elements of x
for j = 1:dim_num
    y = [0;0];
    if y(j) ~= 0
        y(j) = (1 + usual_delta)*y(j);
    else
        y(j) = zero_term_delta;
    end
    x(:,j+1) = y;
end

tol = 1e-8;

rho = 1; 
chi = 2; 
psi = 0.5; 
sigma = 0.5;

for ii = 1 : maxIter
    % sort
    for kk = 1 : ver_num
        f(:,kk) = fun(x(:,kk));
    end
    [f,seq] = sort(f);
    x = x(:,seq);
    if max(norm(x(:,1)-x(:,end)),abs(f(1)-f(end)))<tol
        break
    end
   
    x_mean = mean(x,2);
    x_r = x_mean + rho * (x_mean-x(:,end));
    f_r = fun(x_r);
    shrink = 0;
    if f_r < f(1)
        x_e = x_mean + rho*chi*(x_mean-x(:,end));
        f_e = fun(x_e);
        if f_e < f_r
            x(:,end) = x_e;
            f(:,end) = fun(x(:,end));
        else
            x(:,end) = x_r;
            f(:,end) = fun(x(:,end)); 
        end
    else
        if f_r < f(end-1)
            x(:,end) = x_r;
            f(:,end) = fun(x(:,end));
        else
            if f_r < f(end)
                x_oc = x_mean + psi*rho*(x_mean-x(:,end));
                f_oc = fun(x_oc);
                if f_oc <= f_r
                    x(:,end) = x_oc;
                    f(:,end) = fun(x(:,end));
                else
                    shrink = 1;
                end
            else
                x_ic = x_mean + psi*(x(:,end)-x_mean);
                f_ic = fun(x_ic); 
                if f_ic < f(end)
                    x(:,end) = x_ic;
                    f(:,end) = fun(x(:,end));
                else
                    shrink = 1;
                end
            end
            if shrink == 1
                for jj = 2 : ver_num
                    x(:,jj) = x(:,1)+sigma*(x(:,jj)-x(:,1));
                    f(:,jj) = fun(x(:,jj));
                end
            end
        end
    end
end

x_opt = x(:,end);
x_val = -fun(x(:,end));

if display == 1
    fprintf(['iteration' num2str(ii) ': the optimal value is' num2str(x_val) '.\n']);
end

end