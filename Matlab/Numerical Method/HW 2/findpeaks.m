function [ func_peaks ] = findpeaks( erks,dt )

for ii = 2 : length(erks)-1
    if erks(ii)>=erks(ii+1) && erks(ii)>=erks(ii-1)
        func_peak1(1,ii) = erks(ii);
        func_peak1(2,ii) = ii*dt;
    end
end

for ii = 2 : length(erks)-1
    if erks(ii)<=erks(ii+1) && erks(ii)<=erks(ii-1)
        func_peak2(1,ii) = erks(ii);
        func_peak2(2,ii) = ii*dt;
    end
end

func_peak1(func_peak1==0)=[];
func_peak2(func_peak2==0)=[];

func_peak1 = reshape(func_peak1,2,[]);
func_peak2 = reshape(func_peak2,2,[]);

if length(func_peak1) == 24
    func_peaks(1:2,1) = [1,0];
    func_peaks(1:2,2:24) = func_peak1(:,2:24);
else func_peaks(1:2,1) = [1,0];
    func_peaks(1:2,2:24) = func_peak1;
end
    
func_peaks(3:4,:) = func_peak2;

end

