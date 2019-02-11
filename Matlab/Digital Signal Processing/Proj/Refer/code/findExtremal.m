function [res] = findExtremal(yyy,ww)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

N = length(yyy);

res = [];
for ii = 2:N-1
    if(yyy(ii-1)<yyy(ii) && yyy(ii)>yyy(ii+1))
        res = [res ww(ii)];
    end
end

end

