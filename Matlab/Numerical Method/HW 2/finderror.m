function [ error ] = finderror( y,yfact )

for ii = 1 : length(y)
    jj = round(ii*length(yfact)/length(y));
    y_fact(:,ii) = yfact(:,jj);
end

err_num = norm(y_fact - y);
err_den = norm(y_fact);
error = err_num/err_den;

end

