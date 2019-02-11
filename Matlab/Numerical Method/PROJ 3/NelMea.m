function [ x_opt,x_val,iter ] = NelMea( func,bounds,options )

% Nelder_Mead
fun =@(x) -func(x);
maxIter = options.maxIter;
display = options.display;
dim_num = size(bounds,1);
ver_num = 50;
x_rand = rand(dim_num,ver_num);
for ii = 1 : ver_num
    x(:,ii) = x_rand(:,ii).*(bounds(:,2)-bounds(:,1)) + bounds(:,1);
end

tol = 1e-15;

alpha = 1;
beta = 1+2/dim_num;
gamma = 0.75-1/(2*dim_num);
theta = 1-1/dim_num;

% alpha = 1;
% beta = 2;
% gamma = 1/2;
% theta = 1/2;


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
    x_init(ii,:) = [x(:,1)',f(:,1)];
    x_end(ii,:) = [x(:,end)',f(:,end)];
   
    x_mean = mean(x,2);
    x_r = x_mean + alpha * (x_mean-x(:,end));
    f_r = fun(x_r);
    shrink = 0;
    if f_r < f(1)
        x_e = x_mean + beta*(x_r-x_mean);
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
                x_oc = x_mean + gamma*(x_r-x_mean);
                f_oc = fun(x_oc);
                if f_oc <= f_r
                    x(:,end) = x_oc;
                    f(:,end) = fun(x(:,end));
                else
                    shrink = 1;
                end
            else
                x_ic = x_mean - gamma*(x_r-x_mean);
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
                    x(:,jj) = x(:,1)+theta*(x(:,jj)-x(:,1));
                    f(:,jj) = fun(x(:,jj));
                end
            end
        end
    end
end

x_opt = x(:,end);
x_val = -fun(x(:,end));
iter = ii;

end

