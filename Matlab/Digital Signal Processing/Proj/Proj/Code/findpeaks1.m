function [ w_max1,max_num1 ] = findpeaks1( ww,yyy )

D = (ww<=pi/32);
seq = abs(yyy.*D-1);
D(D==0) = [];
L = length(D);

peaks = [];
for ii = 2 : L-1
    if seq(ii)>seq(ii+1) && seq(ii)>seq(ii-1)
        peaks = [peaks,[ww(ii);seq(ii)]];
    end
end

w_max1 = sort([0,pi/32,peaks(1,:)]);
max_num1 = length(w_max1);

end