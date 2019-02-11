function [ new_peppers ] = nearest_nei( peppers,new_size )

old_size = size(peppers);
if new_size(1) == 1
    new_peppers=peppers(1+round(old_size(2)*[0:new_size(2)-1]/new_size(2)));
elseif new_size(2) == 1
    new_peppers=peppers(1+round(old_size(1)*[0:new_size(1)-1]/new_size(1)));
else
    new_peppers=peppers(1+round(old_size(1)*[0:new_size(1)-1]/new_size(1)), ...
        1+round(old_size(2)*[0:new_size(2)-1]/new_size(2)));
end

end

