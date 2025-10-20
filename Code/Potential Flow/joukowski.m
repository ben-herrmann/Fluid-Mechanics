clear variables; close all; clc;

U = 1;
alpha = pi/12;

x0 = -0.1;
y0 = 0.25;
z0 = x0+1i*y0;           % cylinder center
a = sqrt((1-x0)^2+y0^2); % cylinder radius

beta = asin(y0/a);
Gamma = 4*pi*a*U*sin(beta+alpha); % Kutta condition
%
n = 501;
r = linspace(a-1e-6,8*a,n);
t = linspace(-pi,pi,n); 

[r,t] = meshgrid(r,t);
x = r.*cos(t);
y = r.*sin(t);
z = x+1i*y;

Phi = U*(z + a^2./z) + 1i*Gamma/(2*pi)*log(z/a);

z = z*exp(1i*alpha);
z = z+z0;
z = z + 1./z;
x = real(z); y = imag(z);


phi = real(Phi); phi = phi - phi((n-1)/4+1,1);
psi = imag(Phi); 
%
% figure(1)
% contour(x,y,phi,20,'r'), hold on
% contour(x,y,psi,20,'b'), hold off
%% prettier figure
dphi = phi(1,1)-phi(n,1);
l = 20;
phi_levs = 0:dphi/l:max(abs(phi(:)));
phi_levs = [-fliplr(phi_levs(2:end)) phi_levs];
psi_levs = linspace(-max(abs(psi(:))),max(abs(psi(:))),101);
contour(x,y,phi,phi_levs,'r','LineWidth',1.4), hold on
contour(x,y,psi,psi_levs,'b','LineWidth',1.4), hold off, axis equal, axis tight
xlim([-4,4]), ylim([-3,3])
% xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')
set(gcf,'Color','w')
xticks([]); yticks([]);
