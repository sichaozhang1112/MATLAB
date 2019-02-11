%% optimal policy test: 4*4 grid
grid_o = zeros(6,6);
grid_n = zeros(6,6);
grid_o(5,5) = 1;
grid_o(3,4) = -1;

%%
for nn = 1 : 120
    f1 =@(ii,jj) 0.8*grid_o(ii+1,jj)+0.2*grid_o(ii,jj+1);
    f2 =@(ii,jj) 0.8*grid_o(ii,jj+1)+0.2*grid_o(ii+1,jj);
    f3 =@(ii,jj) 0.6*grid_o(ii+1,jj)+0.4*grid_o(ii,jj+1);
    f4 =@(ii,jj) 0.6*grid_o(ii,jj+1)+0.4*grid_o(ii+1,jj);
    for ii = 2 : 5
        for jj = 2 : 5
            grid_n(ii,jj) = -0.04+max([f1(ii,jj),f2(ii,jj),f3(ii,jj),f4(ii,jj)]);
        end
    end
    grid_n(2,2) = -0.04+max([f1(ii,jj),f2(ii,jj)]);
    grid_o = grid_n;
    grid_o(3,4)=-1;
    grid_o(5,5)=1;
    grid_o(2:5,6)=grid_o(2:5,5);
    grid_o(6,2:5)=grid_o(5,2:5);
end

optimalpolicy = grid_o(2:5,2:5)
