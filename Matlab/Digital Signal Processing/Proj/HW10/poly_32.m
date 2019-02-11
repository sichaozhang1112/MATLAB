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

