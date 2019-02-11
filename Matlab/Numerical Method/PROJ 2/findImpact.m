function t_next = findImpact(t0,X0,V0)
g = 9.81 ;
t_next = (t0+V0/g)+sqrt(V0^2/g^2+2*X0/g) ;
end
