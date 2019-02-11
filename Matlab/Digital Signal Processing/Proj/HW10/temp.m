fid = fopen('peppers.raw','rb','b');
peppers = fread(fid,[512,512])';

N = 15*32+1;
box = boxcar(N)';
han = hanning(N)';
ham = hamming(N)';
harm = sinc((-floor(N/2):floor(N/2))/32);
filter_ham = ham .* harm;
filter_han = han .* harm;
filter_box = box .* harm;
%%
peppers_12 = peppers;
for ii = 1 : 12
    size = [600+(ii-1)*50,600+(ii-1)*50];
    peppers_temp = polyphase(peppers_12,filter_han);
    peppers_12 = nearest_nei(peppers_temp,size);
end

peppers512 = nearest_nei(peppers_temp,[512,512]);

error_image = (peppers - peppers512)*50;
errornorm_IDR12 = norm(peppers - peppers512,'fro');
% figure(7)
figure('Units', 'pixels','Position',[100 100 512 512]);
image(error_image), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);
%