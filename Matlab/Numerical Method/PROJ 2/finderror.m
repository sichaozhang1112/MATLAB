function [ error ] = finderror( y,yfact )

for ii = 1 : length(y)
    jj = round(ii*length(yfact)/length(y));
    y_fact(:,ii) = yfact(:,jj);
end

error = norm(y_fact - y);

end

