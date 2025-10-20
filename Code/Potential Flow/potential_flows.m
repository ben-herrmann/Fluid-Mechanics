clear variables; close all; clc;

n = 100;
x = linspace(-2,2,n);
y = linspace(-2,2,n);
[x,y] = meshgrid(x,y);
z = x+1i*y;

% % Corner flow
% U = 1;
% N = 3;
% Phi = U*z.^N;

% % Uniform flow
% U = 1;
% alpha = pi/12;
% Phi = U*z*exp(-1i*alpha);
% 
% % Source/sink
% q = 1;
% Phi = q/(2*pi)*log(z);
% 
% % Doublet
% K = 1;
% Phi = K./(2*pi*z);
% 
% Vortex
% Gamma = 1;
% Phi = -1i*Gamma/(2*pi)*log(z);
% 
% Vortex dipole
Gamma = 1; d = 1;
Phi = -1i*Gamma/(2*pi)*log((z+d)./(z-d));

phi = real(Phi);
psi = imag(Phi);

figure(1)
lvs = 21;
contour(x,y,phi,lvs,'r','LineWidth',1.4), hold on
contour(x,y,psi,lvs,'b','LineWidth',1.4), hold off, axis equal, axis tight
xlim([-2,2]), ylim([-2,2])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')
set(gcf,'Color','w')