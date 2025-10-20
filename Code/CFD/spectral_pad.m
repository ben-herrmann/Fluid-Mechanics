function qp = spectral_pad(q)
% Padding in wavespace (padding to store spurious high freq components)
% NOTE: kxp = [0:(nxp/2),(-nxp/2+1):(-1)]/Lx*2*pi;
%       kyp = [0:(nyp/2),(-nyp/2+1):(-1)]/Ly*2*pi;

[ny,nx] = size(q);
nxp = nx*3/2; nyp = ny*3/2; % dimensions of padded arrays
qp = zeros(nyp,nxp);
qp(1:ny/2+1,1:nx/2+1)       = q(1:ny/2+1,1:nx/2+1);
qp(1:ny/2+1,end-nx/2+2:end) = q(1:ny/2+1,nx/2+2:end);
qp(end-ny/2+2:end,1:nx/2+1) = q(ny/2+2:end,1:nx/2+1);
qp(end-ny/2+2:end,end-nx/2+2:end) = q(ny/2+2:end,nx/2+2:end);
end