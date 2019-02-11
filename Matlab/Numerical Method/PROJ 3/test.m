%%
options.maxIter = 10000 ;
options.display = 1 ;

func = @(x) TwoD_MorletProblem(x) ;
funfcn =@(x) -func(x);
x = [0;0];

% defaultopt = struct('Display','notify','MaxIter','200*numberOfVariables',...
%     'MaxFunEvals','200*numberOfVariables','TolX',1e-4,'TolFun',1e-4, ...
%     'FunValCheck','off','OutputFcn',[],'PlotFcns',[]);
% 
% % If just 'defaults' passed in, return the default options in X
% if nargin==1 && nargout <= 1 && strcmpi(funfcn,'defaults')
%     x = defaultopt;
%     return
% end
% 
% if nargin<3, options = []; end
% 
% % Detect problem structure input
% if nargin == 1
%     if isa(funfcn,'struct') 
%         [funfcn,x,options] = separateOptimStruct(funfcn);
%     else % Single input and non-structure
%         error('MATLAB:fminsearch:InputArg',...
%             getString(message('MATLAB:optimfun:fminsearch:InputArg')));
%     end
% end
% 
% if nargin == 0
%     error('MATLAB:fminsearch:NotEnoughInputs',...
%         getString(message('MATLAB:optimfun:fminsearch:NotEnoughInputs')));
% end
% 
% 
% % Check for non-double inputs
% if ~isa(x,'double')
%   error('MATLAB:fminsearch:NonDoubleInput',...
%     getString(message('MATLAB:optimfun:fminsearch:NonDoubleInput')));
% end
% 
% n = numel(x);
% numberOfVariables = n;
% 
% % Check that options is a struct
% if ~isempty(options) && ~isa(options,'struct')
%     error('MATLAB:fminsearch:ArgNotStruct',...
%         getString(message('MATLAB:optimfun:commonMessages:ArgNotStruct', 3)));
% end
% 
% printtype = optimget(options,'Display',defaultopt,'fast');
% tolx = optimget(options,'TolX',defaultopt,'fast');
% tolf = optimget(options,'TolFun',defaultopt,'fast');
% maxfun = optimget(options,'MaxFunEvals',defaultopt,'fast');
% maxiter = optimget(options,'MaxIter',defaultopt,'fast');
% funValCheck = strcmp(optimget(options,'FunValCheck',defaultopt,'fast'),'on');
% 
% % In case the defaults were gathered from calling: optimset('fminsearch'):
% if ischar(maxfun) || isstring(maxfun)
%     if strcmpi(maxfun,'200*numberofvariables')
%         maxfun = 200*numberOfVariables;
%     else
%         error('MATLAB:fminsearch:OptMaxFunEvalsNotInteger',...
%             getString(message('MATLAB:optimfun:fminsearch:OptMaxFunEvalsNotInteger')));
%     end
% end
% if ischar(maxiter) || isstring(maxiter)
%     if strcmpi(maxiter,'200*numberofvariables')
%         maxiter = 200*numberOfVariables;
%     else
%         error('MATLAB:fminsearch:OptMaxIterNotInteger',...
%             getString(message('MATLAB:optimfun:fminsearch:OptMaxIterNotInteger')));
%     end
% end
% 
% switch printtype
%     case {'notify','notify-detailed'}
%         prnt = 1;
%     case {'none','off'}
%         prnt = 0;
%     case {'iter','iter-detailed'}
%         prnt = 3;
%     case {'final','final-detailed'}
%         prnt = 2;
%     case 'simplex'
%         prnt = 4;
%     otherwise
%         prnt = 1;
% end
% % Handle the output
% outputfcn = optimget(options,'OutputFcn',defaultopt,'fast');
% if isempty(outputfcn)
%     haveoutputfcn = false;
% else
%     haveoutputfcn = true;
%     xOutputfcn = x; % Last x passed to outputfcn; has the input x's shape
%     % Parse OutputFcn which is needed to support cell array syntax for OutputFcn.
%     outputfcn = createCellArrayOfFunctions(outputfcn,'OutputFcn');
% end
% 
% % Handle the plot
% plotfcns = optimget(options,'PlotFcns',defaultopt,'fast');
% if isempty(plotfcns)
%     haveplotfcn = false;
% else
%     haveplotfcn = true;
%     xOutputfcn = x; % Last x passed to plotfcns; has the input x's shape
%     % Parse PlotFcns which is needed to support cell array syntax for PlotFcns.
%     plotfcns = createCellArrayOfFunctions(plotfcns,'PlotFcns');
% end
% 
% header = ' Iteration   Func-count     min f(x)         Procedure';
% 
% % Convert to function handle as needed.
% funfcn = fcnchk(funfcn,length(varargin));
% % Add a wrapper function to check for Inf/NaN/complex values
% if funValCheck
%     % Add a wrapper function, CHECKFUN, to check for NaN/complex values without
%     % having to change the calls that look like this:
%     % f = funfcn(x,varargin{:});
%     % x is the first argument to CHECKFUN, then the user's function,
%     % then the elements of varargin. To accomplish this we need to add the 
%     % user's function to the beginning of varargin, and change funfcn to be
%     % CHECKFUN.
%     varargin = [{funfcn}, varargin];
%     funfcn = @checkfun;
% end

n = numel(x);

% Initialize parameters
rho = 1; chi = 2; psi = 0.5; sigma = 0.5;
onesn = ones(1,n);
two2np1 = 2:n+1;
one2n = 1:n;

% Set up a simplex near the initial guess.
xin = x(:); % Force xin to be a column vector
v = zeros(n,n+1); fv = zeros(1,n+1);
v(:,1) = xin;    % Place input guess in the simplex! (credit L.Pfeffer at Stanford)
x(:) = xin;    % Change x to the form expected by funfcn
fv(:,1) = funfcn(x);
func_evals = 1;
itercount = 0;
how = '';
%%
usual_delta = 0.05;             % 5 percent deltas for non-zero terms
zero_term_delta = 0.00025;      % Even smaller delta for zero elements of x
for j = 1:n
    y = xin;
    if y(j) ~= 0
        y(j) = (1 + usual_delta)*y(j);
    else
        y(j) = zero_term_delta;
    end
    v(:,j+1) = y;
    x(:) = y; f = funfcn(x);
    fv(1,j+1) = f;
end

% sort so v(1,:) has the lowest function value
[fv,j] = sort(fv);
v = v(:,j);