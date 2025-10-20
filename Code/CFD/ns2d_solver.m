function f = ns2d_solver(nu,Lx,Ly,nx,ny)
%####################################################%
% Fourier spectral solver for the 2D incompressible  %
% Navier-Stokes equation in a doubly-periodic domain %
% based on the vorticity-streamfunction formulation  %
%                                                    %
% Author: Benjamin Herrmann, PUC Chile, 2025.        %
%                                                    %
% The code is written for educational clarity and    %
% not for speed.                                     %
%####################################################%

% Check if nx and ny are even
if (mod(nx,2)+mod(ny,2))>0
    error('--- nx and ny must be divisible by 2')
end

% Fourier wavenumbers
kx  = [0:(nx/2),(-nx/2+1):(-1)]'*2*pi/Lx;
ky  = [0:(ny/2),(-ny/2+1):(-1)]'*2*pi/Ly;

% 2D operators
[Kx,Ky] = meshgrid(kx,ky);
Lap = -(Kx.^2+Ky.^2);
iLap = 1./Lap;
iLap(1,1) = 0; % this entry corresponds to kx=kx=0

% Dynamics in spectral space
    function domghat = ns2d(omghat)
        omghat = reshape(omghat,ny,nx);
        psihat = -iLap.*omghat;
        u = ifft2(1i*Ky.*psihat);   % u = dPsidy
        v = ifft2(-1i*Kx.*psihat);  % v = -dPsidx
        domgdx = ifft2(1i*Kx.*omghat);
        domgdy = ifft2(1i*Ky.*omghat);
        advhat = fft2(-u.*domgdx - v.*domgdy);
        domghat = nu*Lap.*omghat + advhat;
        domghat = domghat(:);
    end

% Return dynamics
f = @(t,omghat) ns2d(omghat);

end