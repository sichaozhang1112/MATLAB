function [ opt_x,opt_y,opt_f ] = uni_quad( f,x0,y0,trange,mode )

if (sin(2*pi*x0)==0 && mode==1) || (cos(pi*y0)==0 && mode==0)
    opt_x = x0;
    opt_y = y0;
    opt_f = f(x0,y0);
else

if mode == 0
    x_0(:,1) = trange(1);
    x_2(:,1) = trange(end);
    x_1(:,1) = 1/3 * (trange(end)-trange(1)) + trange(1);
    for ii = 1 : 1000
        x_star(:,ii) = (f(x_0(:,ii),y0)*(x_1(:,ii)^2-x_2(:,ii)^2)+f(x_1(:,ii),y0)*(x_2(:,ii)^2-x_0(:,ii)^2)+f(x_2(:,ii),y0)*(x_0(:,ii)^2-x_1(:,ii)^2))/(2*f(x_0(:,ii),y0)*(x_1(:,ii)-x_2(:,ii))+2*f(x_1(:,ii),y0)*(x_2(:,ii)-x_0(:,ii))+2*f(x_2(:,ii),y0)*(x_0(:,ii)-x_1(:,ii)));
        if abs(x_1(:,ii) - x_star(:,ii)) == 0
            break
        end
        if f(x_1(:,ii),y0)>f(x_star(:,ii),y0)
            x_0(:,ii+1) = x_0(:,ii);
            x_1(:,ii+1) = x_1(:,ii);
            x_2(:,ii+1) = x_star(:,ii);
        else
            x_0(:,ii+1) = x_1(:,ii);
            x_1(:,ii+1) = x_star(:,ii);
            x_2(:,ii+1) = x_2(:,ii); 
        end
    end
    opt_x = x_star(end);
    opt_y = y0;
    opt_f = f(opt_x,opt_y);
elseif mode == 1
    y_0(:,1) = trange(1);
    y_2(:,1) = trange(end);
    y_1(:,1) = 1/3 * (trange(end)-trange(1)) + trange(1);
    for ii = 1 : 1000
        y_star(:,ii) = (f(x0,y_0(:,ii))*(y_1(:,ii)^2-y_2(:,ii)^2)+f(x0,y_1(:,ii))*(y_2(:,ii)^2-y_0(:,ii)^2)+f(x0,y_2(:,ii))*(y_0(:,ii)^2-y_1(:,ii)^2))/(2*f(x0,y_0(:,ii))*(y_1(:,ii)-y_2(:,ii))+2*f(x0,y_1(:,ii))*(y_2(:,ii)-y_0(:,ii))+2*f(x0,y_2(:,ii))*(y_0(:,ii)-y_1(:,ii)));
        if abs(y_1(:,ii) - y_star(:,ii)) == 0
            break
        end
        if f(x0,y_1(:,ii))>f(x0,y_star(:,ii))
            y_0(:,ii+1) = y_0(:,ii);
            y_1(:,ii+1) = y_1(:,ii);
            y_2(:,ii+1) = y_star(:,ii);
        else
            y_0(:,ii+1) = y_1(:,ii);
            y_1(:,ii+1) = y_star(:,ii);
            y_2(:,ii+1) = y_2(:,ii); 
        end
    end
    opt_x = x0;
    opt_y = y_star(end);
    opt_f = f(opt_x,opt_y);
end

end

end

