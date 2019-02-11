function [ ww_n ] = mid_interp( ww )

for ii = 1 : length(ww)-1
    ww1(ii) = 0.5*(ww(ii)+ww(ii+1));
end

ww_up = upsample(ww,2);
if length(ww1) <= 1
    ww1_up = upsample(ww1,2)';
else
    ww1_up = upsample(ww1,2);
end
ww_n = ww_up(1:end-1)+[0,ww1_up];

end

