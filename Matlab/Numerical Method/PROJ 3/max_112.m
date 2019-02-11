function [ x_opt,x_val ] = max_112( func,bounds,options )

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

x_break = zeros(2*dim_num,ver_num);
tol = 1e-15;

% rho = 1; 
% chi = 2; 
% psi = 0.5; 
% sigma = 0.5;

rho = 1; 
chi = 1+2/dim_num; 
psi = 0.75-0.5/dim_num; 
sigma = 1-1/dim_num;

for ii = 1 : maxIter
    % sort
    for kk = 1 : ver_num
        f(:,kk) = fun(x(:,kk));
    end
    [f,seq] = sort(f);
    x = x(:,seq);
    x_break(1:dim_num,:) = x_break(dim_num+1:2*dim_num,:);
    x_break(dim_num+1:2*dim_num,:) = x;
    x_diff = x_break(dim_num+1:2*dim_num,:)-x_break(1:dim_num,:);
    if norm(x_diff,'fro')<tol
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

x_opt = x(:,1);
x_val = -fun(x(:,1));

if display == 1
    fprintf(['iteration' num2str(ii) ': the optimal value is' num2str(x_val) '.\n']);
end

end