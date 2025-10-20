%%
clear variables; close all; clc;

% import data
load('cylinder_flow.mat');

%% Explore variables

size(t)
size(CL)
size(x)
size(y)
size(U)

%% Plot aerodynamic forces

figure(1)
plot(t,CD,'r-',t,CL,'b-','LineWidth',1.2)
xlabel('Time, t'), ylabel('Force coefficients')
legend('CD','CL','Location','northwest')
fontsize(18,'points'), fontname('Times')
xlim([0,t(end)]), ylim([-1,2])
pbaspect([3 2 1])

% saveas(gcf,'forces.png')

%% Plot cylinder

plot_cyl(), axis equal
xlim([min(x),max(x)]), ylim([min(y),max(y)])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

%% Plot scalar field

figure(3)

for i=1:m

q = Omg(:,:,i);

pcolor(x,y,q), shading interp
axis equal, axis tight
% xlim([-3,15]); ylim([-3,3])
% xlim([min(x),max(x)]), ylim([min(y),max(y)])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')
colorbar(), clim([-1,1])
colormap(redblueTecplot())

hold on
plot_cyl()
hold off

drawnow()

end

% saveas(gcf,'vorticity_field.png')

%% Plot velocity field
figure(4)
d = 5;

for i=1:m

Ui = U(1:d:end,1:d:end,i);
Vi = V(1:d:end,1:d:end,i);

quiver(x(1:d:end),y(1:d:end),Ui,Vi,1.3,'k','LineWidth',1.2)
axis equal, axis tight
xlim([-3,10]); ylim([-3,3])
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')

hold on
plot_cyl()
hold off

drawnow()

end

% saveas(gcf,'velocity_field.png')
