function [output_list] = linear_interp(input_list)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
xx = input_list;
N = length(xx);

left_index = [];
for ii = 1:N-1
    if(~isnan(xx(ii)) && isnan(xx(ii+1)))
        left_index = [left_index ii];
    end
end
% left_index;

right_index = [];
for ii = 2:N
    if ~isnan(xx(ii)) && isnan(xx(ii-1))
        
        right_index = [right_index ii];
    end
end
% right_index;

for ii = 1:length(left_index)
    left = left_index(ii);
    right = right_index(ii);
    tmp = linspace(xx(left),xx(right),right-left+1);
    xx(left:right) = tmp;
end

output_list = xx;

end

