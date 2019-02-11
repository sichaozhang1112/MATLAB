function [ wc_sl ] = wcsl( W )
w = 0 : 0.001 : pi;

for ii = 2 : length(w)
 if (abs(W(w(ii)))>abs(W(w(ii-1)))) && (abs(W(w(ii)))>abs(W(w(ii+1))))
    sl(ii) = abs(W(w(ii)));
 end
end

wc_sl = max(sl);
wc_sl = mag2db(wc_sl/32);

end

