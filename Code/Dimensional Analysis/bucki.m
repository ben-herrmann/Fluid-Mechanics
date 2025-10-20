function Pi = bucki(D,cols)

n = size(D,2);
other_cols = setdiff(1:n,cols);
D1 = D(:,cols);
D2 = D(:,other_cols);

r = rank(D);
r1 = rank(D1);
assert(r==length(cols),[num2str(r) ' column indices need to be specified.']);
assert(r1==r,'The columns specified are not linearly independent.')
m = n-r;
Pi = zeros(r,m);

for i = 1:m
    
b = -D2(:,i);
A = D1;
Pi(:,i) = A\b;

end

end
