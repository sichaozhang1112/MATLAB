function [ opt_x,opt_y,opt_f ] = uni_newton( f,fdot,fdotdot,x0,y0,mode )

tol = 1e-6;

if mode == 0
    temp_x(:,1) = x0;
    temp_y = y0;
    for ii = 1 : 1e3
        if fdotdot(temp_x(:,ii),temp_y) == 0
            temp_x(:,ii) = temp_x(:,ii) + tol;
            temp_y = temp_y + tol;
        end
        if fdot(temp_x(:,ii),temp_y) == 0 && fdotdot(temp_x(:,ii),temp_y)<0
            break
        end
           temp_x(:,ii+1) = temp_x(:,ii) - fdot(temp_x(:,ii),temp_y)/fdotdot(temp_x(:,ii),temp_y);
    end
elseif mode == 1
    temp_x = x0;
    temp_y(:,1) = y0;
    for ii = 1 : 1e3
        if fdotdot(temp_x,temp_y(:,ii)) == 0
            temp_x = temp_x + tol;
            temp_y(:,ii) = temp_y(:,ii) + tol;
        end
        if fdot(temp_x,temp_y(:,ii)) == 0 && fdotdot(temp_x,temp_y(:,ii))<0
            break
        end
            temp_y(:,ii+1) = temp_y(:,ii) - fdot(temp_x,temp_y(:,ii))/fdotdot(temp_x,temp_y(:,ii));
    end
end

opt_x = temp_x(end);
opt_y = temp_y(end);
opt_f = f(opt_x,opt_y);

end

