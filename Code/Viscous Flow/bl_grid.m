function [x,y] = bl_grid(Nx,Ny,x0,xend,yhalf,Ly)

Lx = xend - x0;
x = x0 + fourier_grid(Nx)*Lx/(2*pi);
y = semi_inf_grid(Ny,yhalf,Ly);
% [xx,yy] = meshgrid(x,y);
% x = xx(:); y = yy(:);

end