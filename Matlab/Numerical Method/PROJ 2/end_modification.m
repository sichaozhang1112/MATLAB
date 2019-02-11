function [ t_new,y_new ] = end_modification( time,t,y )

t(t>time) = [];
t_temp = t;
y_temp = y(1:length(t_temp));

if t_temp(end) == time
        t_new = t_temp;
        y_new = y_temp;
else
        t_new = t_temp;
        y_new = y_temp;
        t_new(end) = time;
        y_new(end) = y(end)+(t(end)-time)*(y(end)-y(end-1))/(t(end)-y(end-1));
end

end

