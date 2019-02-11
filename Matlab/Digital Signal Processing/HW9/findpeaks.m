function [ w_max ] = findpeaks( seq )

for ii = 2 : length(seq)-1
    if seq(ii)>seq(ii+1) && seq(ii)>seq(ii-1)
        peaks(ii,1) = seq(ii);
        peaks(ii,2) = (ii-1)*0.01+0.0001;
    end
end


peaks(peaks==0)=[];
w_max(1,:) = peaks(1:0.5*length(peaks));
w_max(2,:) = peaks(0.5*length(peaks)+1:length(peaks));

end



