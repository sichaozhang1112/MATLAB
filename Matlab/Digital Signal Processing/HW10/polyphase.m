function [ new_peppers ] = polyphase( peppers,filter )

[x,y] = size(peppers);

e = filter_mod(filter);

for yy = 1 : y
    peppers_y(yy,:) = poly_32(peppers(yy,:),e);
end

for xx = 1 : x*32
    peppers_x(:,xx) = poly_32(peppers_y(:,xx)',e)';
end

new_peppers = peppers_x;


end

