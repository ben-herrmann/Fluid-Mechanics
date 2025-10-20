function q = spectral_chop(qp)
% Chopping in wavespace (remove spurious high-frequency components)
% NOTE: kxp = [0:(nxp/2),(-nxp/2+1):(-1)]/Lx*2*pi;
%       kyp = [0:(nyp/2),(-nyp/2+1):(-1)]/Ly*2*pi;
[nyp,nxp] = size(qp);
ny = nyp*2/3; nx = nxp*2/3;
q = zeros(ny,nx);
q(1:ny/2+1,1:nx/2+1) = qp(1:ny/2+1,1:nx/2+1);
q(1:ny/2+1,nx/2+2:end) = qp(1:ny/2+1,end-nx/2+2:end);
q(ny/2+2:end,1:nx/2+1) = qp(end-ny/2+2:end,1:nx/2+1);
q(ny/2+2:end,nx/2+2:end) = qp(end-ny/2+2:end,end-nx/2+2:end);
q = q*1.5*1.5;
end