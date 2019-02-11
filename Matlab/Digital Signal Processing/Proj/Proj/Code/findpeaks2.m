function [ w_max2,max_num2 ] = findpeaks2( ww,yyy,epsilon )

% cut-off frequncy
yyy_cut = yyy-abs(epsilon);
for ii = 1 : size(ww,2)
    if yyy_cut(ii)*yyy_cut(ii+1)<0
        ww_cut = (ww(ii+1)-ww(ii))*yyy_cut(ii)/(yyy_cut(ii)+yyy_cut(ii+1))+ww(ii);
        break
    end
end

D = (ww>=ww_cut);
seq = abs(yyy.*D);
D(D==1) = [];
L = length(D);

peaks = [];
for ii = L+1 : length(ww)-1
    if seq(ii)>seq(ii+1) && seq(ii)>seq(ii-1)
        peaks = [peaks,[ww(ii);seq(ii)]];
    end
end

% w_max2 = sort([ww_cut,peaks(1,:)]);
w_max2 = peaks(1,:);
max_num2 = length(w_max2);

end



