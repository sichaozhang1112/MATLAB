function [ func_zeros ] = findzeros( erks,dt )

for ii = 1 : length(erks)-1
    if erks(ii)*erks(ii+1) <= 0
        func_zeros(ii) = erks(ii)/(erks(ii)-erks(ii+1)) + ii;
    end
end

if erks(end) == 0
    func_zeros(length(erks)) = length(erks);
end

func_zeros(func_zeros==0)=[];

func_zeros = func_zeros*dt;

end

