function [ intersect ] = check_inter( P11,P12,P21,P22 )

c1 = relation_inter(P11,P21,P22);
c2 = relation_inter(P12,P21,P22);
c3 = relation_inter(P21,P11,P12);
c4 = relation_inter(P22,P11,P12);

if (c1*c2<0) && (c3*c4<0)
    intersect = 'intersect';
elseif (c1==0) && ((P11(1)-P21(1))*(P11(1)-P22(1))<=0)
    intersect = 'intersect';
elseif (c2==0) && ((P12(1)-P21(1))*(P12(1)-P22(1))<=0)
    intersect = 'intersect';
elseif (c3==0) && ((P21(1)-P11(1))*(P21(1)-P12(1))<=0)
    intersect = 'intersect';
elseif (c4==0) && ((P22(1)-P11(1))*(P22(1)-P12(1))<=0)
    intersect = 'intersect';
else 
    intersect = 'not intersect';

end


