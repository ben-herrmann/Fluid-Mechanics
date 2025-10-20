function f = ns2d_solver_dealiased(nu,x,y)
%####################################################%
% Fourier spectral solver for the 2D incompressible  %
% Navier-Stokes equation in a doubly-periodic domain %
% based on the vorticity-streamfunction formulation  %
% including 3/2 dealiasing                           %
%                                                    %
% Author: Benjamin Herrmann, PUC Chile, 2025.        %
%                                                    %
% The code is written for educational clarity and    %
% not for speed.                                     %
%####################################################%

% Array dimensions and length scales
ny = length(y); nx = length(x);
Lx = x(nx)-x(1)+(x(2)-x(1));
Ly = y(ny)-y(1)+(y(2)-y(1));

% Check if nx and ny are even
if (mod(nx,2)+mod(ny,2))>0
    error('--- nx and ny must be divisible by 2')
end

% Fourier wavenumbers
kx  = [0:(nx /2),(-nx /2+1):(-1)]'/Lx*2*pi;
ky  = [0:(ny /2),(-ny /2+1):(-1)]'/Ly*2*pi;

% 2D operators
[Kx,Ky] = meshgrid(kx,ky);
Lap = -(Kx.^2+Ky.^2);
iLap = 1./Lap;
iLap(1,1) = 0; % this entry corresponds to kx=kx=0

% Dynamics in spectral space
    function domghat = ns2d(omghat)
        omghat = reshape(omghat,ny,nx);               % reshape vector as a matrix
        psihat = -iLap.*omghat;                       % Psi = Lap^(-1) omg
        up = ifft2(spectral_pad(1i*Ky.*psihat));      % u = dPsidy
        vp = ifft2(spectral_pad(-1i*Kx.*psihat));     % v = -dPsidx
        domgdxp = ifft2(spectral_pad(1i*Kx.*omghat)); % domgdx for advective term
        domgdyp = ifft2(spectral_pad(1i*Ky.*omghat)); % domgdy for advective term
        advhat = spectral_chop(...                    % adv = u domgdx + v domgdy
            fft2(-up.*domgdxp - vp.*domgdyp));        % in physical space then fft
        domghat = nu*Lap.*omghat + advhat;            % domgdt = nu Lap omg + adv      
        domghat = domghat(:);                         % reshape matrix as a vector
    end

% Return dynamics
f = @(t,omghat) ns2d(omghat);

end