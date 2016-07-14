function [P] = testrandomization()
interval_length = 10;
min_space = 1;
n = 4;
E = interval_length-(n-1)*min_space;

ro = rand(n+1,1);
rn = E*ro(1:n)/sum(ro);

s = min_space*ones(n,1)+rn;

P=cumsum(s)-1;

disp(P)

end