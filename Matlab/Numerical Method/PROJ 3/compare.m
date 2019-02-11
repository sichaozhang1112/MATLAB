function [ x_opt,x_val,iter ] = compare( func,bounds,options )
x_0 = zeros(size(bounds,1),1);
for cntr = 1 : size(bounds,1)
    x_0(cntr) = mean(bounds(cntr,:));
end
if isfield(options,'maxIter')
    opts.MaxIter = options.maxIter;
end
if isfield(options,'display')
    if options.display == 1
        opts.Display = 'iter';
    else
        opts.Display = 'off';
    end
else
    opts.Display = 'off';
end
opts.TolX = eps;
opts.TolFun = eps;
fminfunc = @(x) -func(x);
[ x_opt,x_val ] = fminsearch( fminfunc,x_0,opts );
x_val = -x_val;
iter = 0;

end