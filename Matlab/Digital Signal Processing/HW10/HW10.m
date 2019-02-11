%
%% ELEC-558 Homework10
%% Sichao Zhang
%
%%
fid = fopen('peppers.raw','rb','b');
peppers = fread(fid,[512,512])';
fclose(fid);

figure('Units', 'pixels','Position',[100 100 512 512]);
image(peppers), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);
%
%% Nearest-Neighbor Resizing:
peppers600=peppers(1+round(512*[0:599]/600),1+round(512*[0:599]/600));
figure('Units', 'pixels','Position',[100 100 600 600]);
image(peppers600), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

clear peppers600;
%
%% Bi-linear Interpolation
% 512*512 to 600*600
peppers600 = bilinear_inter(peppers,[600,600]);
figure('Units', 'pixels','Position',[100 100 600 600]);
image(peppers600), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

% 600*600 to 750*750
peppers750 = bilinear_inter(peppers600,[750,750]);
figure('Units', 'pixels','Position',[100 100 750 750]);
image(peppers750), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

% 750*750 to 512*512
peppers512 = bilinear_inter(peppers750,[512,512]);
% figure('Units', 'pixels','Position',[100 100 512 512]);
% image(peppers512), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

% difference
error_image = (peppers - peppers512)*50;
errornorm_bi = norm(peppers - peppers512,'fro');
figure('Units', 'pixels','Position',[100 100 512 512]);
image(error_image), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

clear peppers600 peppers750 peppers512 error_image;
%%
% 12 iterations
peppers_12 = peppers;
for ii = 1 : 12
    size = [600+(ii-1)*50,600+(ii-1)*50];
    peppers_12 = bilinear_inter(peppers_12,size);
end

peppers512 = bilinear_inter(peppers_12,[512,512]);

error_image = (peppers - peppers512)*50;
errornorm_bi12 = norm(peppers - peppers512,'fro');
figure('Units', 'pixels','Position',[100 100 512 512]);
image(error_image), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);
clear peppers_12 peppers512 error_image;
%
%% Interpolation Decimation Resizeing
N = 15*32+1;
box = boxcar(N)';
han = hanning(N)';
ham = hamming(N)';
harm = sinc((-floor(N/2):floor(N/2))/32);
filter_ham = ham .* harm;
filter_han = han .* harm;
filter_box = box .* harm;
%
%%
peppers_up32 = polyphase(peppers,filter_han);

figure('Units', 'pixels','Position',[100 100 512*32 512*32]);
image(peppers_up32), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

peppers600 = nearest_nei(peppers_up32,[600,600]);
peppers750 = nearest_nei(peppers600,[750,750]);
peppers512 = nearest_nei(peppers750,[512,512]);

error_image = (peppers - peppers512)*50;
errornorm_IDR = norm(peppers - peppers512,'fro');
figure('Units', 'pixels','Position',[100 100 512 512]);
image(error_image), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);
clear peppers600 peppers750 peppers512 error_image;
%
% %%
% peppers_12 = peppers;
% for ii = 1 : 12
%     size = [600+(ii-1)*50,600+(ii-1)*50];
%     peppers_temp = polyphase(peppers_12,filter_han);
%     peppers_12 = nearest_nei(peppers_temp,size);
% end
% 
% peppers512 = nearest_nei(peppers_temp,[512,512]);
% 
% error_image = (peppers - peppers512)*50;
% errornorm_IDR12 = norm(peppers - peppers512,'fro');
% figure('Units', 'pixels','Position',[100 100 512 512]);
% image(error_image), colormap(gray(256));
% % set(gca,'Position',[0 0 1 1]);
% %
%% Interpolation Decimation Plus Bi-linear
peppers_up32 = polyphase(peppers,filter_han);

figure('Units', 'pixels','Position',[100 100 512*32 512*32]);
image(peppers_up32), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);

peppers600 = bilinear_inter(peppers_up32,[600,600]);
peppers750 = bilinear_inter(peppers600,[750,750]);
peppers512 = bilinear_inter(peppers750,[512,512]);

error_image = (peppers - peppers512)*50;
errornorm_IDRBI = norm(peppers - peppers512,'fro');
figure('Units', 'pixels','Position',[100 100 512 512]);
image(error_image), colormap(gray(256));
% set(gca,'Position',[0 0 1 1]);
clear peppers_up32 peppers600 peppers750 peppers512 error_image;
%
% %%
% peppers_12 = peppers;
% for ii = 1 : 12
%     size = [600+(ii-1)*50,600+(ii-1)*50];
%     peppers_temp = polyphase(peppers_12,filter_han);
%     peppers_12 = bilinear_inter(peppers_temp,size);
% end
% 
% peppers512 = bilinear_inter(peppers_temp,[512,512]);
% 
% error_image = (peppers - peppers512)*50;
% errornorm_IDR12 = norm(peppers - peppers512,'fro');
% figure('Units', 'pixels','Position',[100 100 512 512]);
% image(error_image), colormap(gray(256));
% % set(gca,'Position',[0 0 1 1]);
% %
%% functions
function [ new_peppers ] = nearest_nei( peppers,new_size )

old_size = size(peppers);
if new_size(1) == 1
    new_peppers=peppers(1+round(old_size(2)*[0:new_size(2)-1]/new_size(2)));
elseif new_size(2) == 1
    new_peppers=peppers(1+round(old_size(1)*[0:new_size(1)-1]/new_size(1)));
else
    new_peppers=peppers(1+round(old_size(1)*[0:new_size(1)-1]/new_size(1)), ...
        1+round(old_size(2)*[0:new_size(2)-1]/new_size(2)));
end

end

function [ new_peppers ] = bilinear_inter( peppers,new_size )

old_size = size(peppers);
rate_y = (old_size(1)-1)/(new_size(1)-1);
rate_x = (old_size(2)-1)/(new_size(2)-1);

for ii = 1 : new_size(1) % y
    for jj = 1 : new_size(2) % x
        n = floor((jj-1)*rate_x+1);
        m = floor((ii-1)*rate_x+1);
        a = (jj-1)*rate_x+1-n;
        b = (ii-1)*rate_x+1-m;
        if n == old_size(2) && m == old_size(1)
            new(jj,ii) = (1-a)*(1-b)*peppers(n,m) ...
                    +a*(1-b)*peppers(n,m) ...
                    +(1-a)*b*peppers(n,m) ...
                    +a*b*peppers(n,m);  
        elseif n == old_size(2)
            new(jj,ii) = (1-a)*(1-b)*peppers(n,m) ...
                    +a*(1-b)*peppers(n,m) ...
                    +(1-a)*b*peppers(n,m+1) ...
                    +a*b*peppers(n,m+1);
        elseif m == old_size(1)
            new(jj,ii) = (1-a)*(1-b)*peppers(n,m) ...
                    +a*(1-b)*peppers(n+1,m) ...
                    +(1-a)*b*peppers(n,m) ...
                    +a*b*peppers(n+1,m);
        else
            new(jj,ii) = (1-a)*(1-b)*peppers(n,m) ...
                    +a*(1-b)*peppers(n+1,m) ...
                    +(1-a)*b*peppers(n,m+1) ...
                    +a*b*peppers(n+1,m+1);
        end
    end
end

new_peppers = new;
end

function [ new_peppers ] = polyphase( peppers,filter )

[x,y] = size(peppers);

e = filter_mod(filter);

for yy = 1 : y
    peppers_y(yy,:) = poly_32(peppers(yy,:),e);
end

for xx = 1 : x*32
    peppers_x(:,xx) = poly_32(peppers_y(:,xx)',e)';
end

new_peppers = peppers_x;


end

function [ new_peppers ] = poly_32( peppers,filter )

new_peppers = zeros(1,length(peppers)*32);
for ii = 1 : 32
    e = downsample(filter,32,ii-1);
    g = conv(peppers,e);
    mid_e = floor(length(e)/2)+1;
    h = g(mid_e:(mid_e+length(peppers)-1));
    f = upsample(h,32,ii-1);
    new_peppers = new_peppers+f;
end

end