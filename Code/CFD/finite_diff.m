function D = finite_diff(n)

% 2nd order central finite difference scheme for 1st derivative
D = 0.5*(diag(ones(n-1,1),1) - diag(ones(n-1,1),-1));

% 2nd order forward finite difference scheme at the left boundary
D(1,:) = [-1.5 2 -0.5 zeros(1,n-3)];

% 2nd order backward finite difference scheme at the right boundary
D(n,:) = [zeros(1,n-3) 0.5 -2 1.5];

end
