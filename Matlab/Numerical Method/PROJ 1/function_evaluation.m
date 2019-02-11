%% Main 

% test functions
func = @(x) x^3;
% test values
xval = 1;

tic
for cntr = 1 : 1000000
    d2f = func_112(func,xval);
end

time = toc/1000000;
error = abs(d2f - 6*xval);

fprintf(['Average Time: ' num2str(time) ' seconds.\n'])
fprintf(['Error of last calculation: ' num2str(error*100) ' %%.\n\n'])

%

