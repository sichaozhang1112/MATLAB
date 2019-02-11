function [ int ] = trapezoid( t,y )

for ii = 1 : (length(y)-1)
    area(ii) = (t(ii+1)-t(ii))*(y(ii+1)+y(ii))/2;
end

int = sum(area);

end

