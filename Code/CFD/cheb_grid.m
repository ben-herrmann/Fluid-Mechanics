function x = cheb_grid(n)
N = n-1;
if N==0,  x=1; return, end
x = cos(pi*(0:N)/N)';