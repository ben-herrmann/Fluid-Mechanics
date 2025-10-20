clear variables; close all; clc;

U = 1;
a = 1;
Gamma = 2*pi;

%
n = 501;
r = linspace(a-1e-6,8*a,n);
t = linspace(-pi,pi,n); 

%t = [t t(2)];
[r,t] = meshgrid(r,t);
x = r.*cos(t);
y = r.*sin(t);
z = x+1i*y;

Phi = U*(z + a^2./z) + 1i*Gamma/(2*pi)*log(z/a);
phi = real(Phi); phi = phi - phi((n-1)/4+1,1);
psi = imag(Phi); %psi = psi - mean(psi(:,1));
%
figure(1)
dphi = phi(1,1)-phi(n,1);
l = 30;
phi_levs = 0:dphi/l:max(abs(phi(:)));
phi_levs = [-fliplr(phi_levs(2:end)) phi_levs];
% phi_levs = linspace(-max(abs(phi(:))),max(abs(phi(:))),51);
psi_levs = linspace(-max(abs(psi(:))),max(abs(psi(:))),81);
contour(x,y,phi,phi_levs,'r','LineWidth',1.4), hold on
contour(x,y,psi,psi_levs,'b','LineWidth',1.4), hold off, axis equal, axis tight
xlim([-4,4]), ylim([-3,3])
% xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')
set(gcf,'Color','w')
xticks([]); yticks([]);