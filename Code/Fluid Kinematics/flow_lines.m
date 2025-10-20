%%
clear variables; close all; clc;
global xx yy tt U V

% import data
load('cylinder_flow.mat');

xx = x; yy = y; tt = t;

%% Pathline

i0 = 300; di = 60;
xp0 = [-3; 0.04];
[~,xp] = ode45(@(t,x)uvec(t,x),tt(i0:i0+di),xp0);
xp = xp';

figure(1)

plot_cyl(), axis equal, axis tight
xlim([-3,15]); ylim([-3,3])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot(xp(1,:),xp(2,:),'k-')
hold off

%% Streamline

figure(2)

for i=i0:i0+di

i0 = 300; di = m-i0;
xp0 = [-3; 0.04];
[~,xp] = ode45(@(t,x)uvec(tt(i),x),tt(i0:i0+di),xp0);
xp = xp';

plot_cyl(), axis equal, axis tight
xlim([-3,12]); ylim([-3,3])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot(xp(1,:),xp(2,:),'k-')
hold off

drawnow()
end

%% Streakline

figure(3)
i0 = 300; di = m-i0;
xp0 = [-3; 0.04];
xstk = xp0;

for i=i0:i0+di

[~,xp] = ode45(@(t,x)uvec(t,x),tt(i:i+1),[xstk(1,:)';xstk(2,:)']);
xp = xp'; xp = xp(:,end); np = length(xp)/2;
xstk = [[xp(1:np)';xp(np+1:2*np)'] xp0];

plot_cyl(), axis equal, axis tight
xlim([-3,12]); ylim([-3,3])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot(xstk(1,:),xstk(2,:),'k.')
hold off

drawnow()
end

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
