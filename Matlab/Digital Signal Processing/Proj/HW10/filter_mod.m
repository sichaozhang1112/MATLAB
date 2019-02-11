function [ e ] = filter_mod( filter )

e = zeros(32,(length(filter)-1)/32+1);
for ii = 1 : 32
    temp_e = downsample(filter,32,ii-1);
    e(ii,1:length(temp_e)) = temp_e;
end

end

