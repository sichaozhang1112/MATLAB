function [ new_peppers ] = polyphase( peppers,filter )

[x,y] = size(peppers);
fil_mod = filter_mod(filter);
for yy = 1 : y
    peppers_y(yy,:) = poly_32(peppers(yy,:),fil_mod);
end
for xx = 1 : x*32
    peppers_x(:,xx) = poly_32(peppers_y(:,xx)',fil_mod)';
end
new_peppers = peppers_x;

function [ new_peppers ] = poly_32( peppers,filter )
new_peppers = zeros(1,length(peppers)*32);
for ii = 1 : 32
    e = downsample(filter,32,ii-1);
    g = conv(peppers,e);
    mid_e = floor(length(e)/2)+1;
    h = g(mid_e:(mid_e+length(peppers)-1));
    f = upsample(h,32,ii-1);
    new_peppers = new_peppers+f;
end
end

end