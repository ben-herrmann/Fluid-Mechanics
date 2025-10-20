function D2 = finite_diff_2(n)

% at the interior points
% 2nd order central finite difference scheme for the 2nd derivative
D2 = -2*eye(n) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);

% at the left boundary
% 2nd order forward finite difference scheme for the 2nd derivative
D2(1,:) = [2 -5 4 -1 zeros(1,n-4)];

% at the right boundary
% 2nd order backward finite difference scheme for the 2nd derivative
D2(n,:) = [zeros(1,n-4) -1 4 -5 2];

end
