function dx = blasius_rhs(x)

% 2*d3f + f*d2f = 0
%x = [f, df, d2f];

dx = [x(2);
      x(3);
      -x(1)*x(3)/2];

end