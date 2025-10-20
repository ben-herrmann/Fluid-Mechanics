function [Dy,Dy2] = bl_diff(y)

Ly = y(end);
yhalf = Ly/4;
a = Ly*yhalf/(Ly-2*yhalf);
b = 1 + a/Ly;

Dy = flipud(cheb_diff(Ny));
Dy2 = Dy^2;
Dyp = diag((2*b*y-y-a)./(y^2));

end