%%
clear variables; close all; clc;
global xx yy tt U V

% import data
load('cylinder_flow.mat');

xx = x; yy = y; tt = t;

%% Integrate particle
i0 = 300; di = 30;
xp0 = [1; -0.7];
[~,xp] = ode45(@(t,x)uvec(t,x),tt(i0:i0+di),xp0);
xp = xp';

%% Plot velocity field
figure(4)
d = 5;

for i=1:di

Ui = U(1:d:end,1:d:end,i+i0-1);
Vi = V(1:d:end,1:d:end,i+i0-1);

quiver(x(1:d:end),y(1:d:end),Ui,Vi,1.3,'k','LineWidth',1.2)
axis equal, axis tight
xlim([-3,12]); ylim([-3,3])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot([xp(1,i)],[xp(2,i)],'ro','MarkerFaceColor','r')

plot_cyl()
hold off

drawnow()

end

%% Integrate blobs
i0 = 300; di = 10;
tspan = tt(i0:i0+di);

xp1 = [1; -0.7];
xb1 = integrate_blob(xp1,tspan);
np = size(xb1,1)/2;

xp2 = [-0.8; 0];
xb2 = integrate_blob(xp2,tspan);

xp3 = [1.45; -0.07];
xb3 = integrate_blob(xp3,tspan);

%% Plot blob deformation
figure(4)
d = 2;

for i=1:3

Ui = U(1:d:end,1:d:end,i+i0-1);
Vi = V(1:d:end,1:d:end,i+i0-1);
% pcolor(xx,yy,Omg(:,:,i+i0-1)), shading interp, colormap('bone'), clim([-5,5])
% hold on
quiver(x(1:d:end),y(1:d:end),Ui,Vi,1.3,'k','LineWidth',1.2)
axis equal, axis tight
xlim([-2,4]); ylim([-1.5,1.5])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot(xb1(1:np,i),xb1(np+1:2*np,i),'r.','MarkerFaceColor','r')
plot(xb2(1:np,i),xb2(np+1:2*np,i),'b.','MarkerFaceColor','b')
plot(xb3(1:np,i),xb3(np+1:2*np,i),'g.','MarkerFaceColor','g')

plot_cyl()
hold off
pause(0.1)
drawnow()

end

% saveas(gcf,'blobs_t2.png')

%%

xp1 = [1; -0.7];
[gradV,S,R] = tensors(tt(i0),xp1)

% xp2 = [-0.8; 0];
% [gradV,S,R] = tensors(tt(i0),xp2)
% 
% xp3 = [1.45; -0.07];
% [gradV,S,R] = tensors(tt(i0),xp3)

%% Functions

function plot_cyl()

theta = (0:200)/200'*2*pi;
xc = 0.5*sin(theta);
yc = 0.5*cos(theta);
fill(xc,yc,0.5*[1 1 1])
hold on
plot(xc,yc,'k','LineWidth',1)
hold off

end

function xvecdot = uvec(t,xvec)

global xx yy tt U V

n = length(xvec)/2;
x = xvec(1:n); y = xvec(n+1:2*n);
t = t*ones(n,1);
u = interpn(yy,xx,tt,U,y,x,t);
v = interpn(yy,xx,tt,V,y,x,t);
xvecdot = [u;
           v];

end

function xb = integrate_blob(xp0,tspan)

h = 0.04;
[xxb0,yyb0] = meshgrid(xp0(1)+(-5:5)*h, xp0(2)+(-5:5)*h);
xb0 = [xxb0(:); yyb0(:)];
np = length(xb0)/2;
[~,xb] = ode45(@(t,x)uvec(t,x),tspan,xb0);
xb = xb';

end

function [gradV,S,R] = tensors(t,xp)

global xx yy tt U V

h = 0.04;
it = tt == t;
[~,ix] = min(abs(xx-xp(1)));
[~,iy] = min(abs(yy-xp(2)));
Ui = U(:,:,it);
Vi = V(:,:,it);
[dudx,dudy] = gradient(Ui,h);
[dvdx,dvdy] = gradient(Vi,h);
gradV = [dudx(iy,ix) dudy(iy,ix);
         dvdx(iy,ix) dvdy(iy,ix)];
S = (gradV + gradV')/2;
R = (gradV - gradV')/2;

end
