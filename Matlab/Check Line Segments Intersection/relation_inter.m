function [ relation ] = relation_inter( p1,p2,p3 )

check = (p1(1)-p3(1))*(p2(2)-p3(2))-(p2(1)-p3(1))*(p1(2)-p3(2));

if check > 0
    relation = 1;
elseif check == 0
        relation = 0;
    else 
        relation = -1;
end

end

