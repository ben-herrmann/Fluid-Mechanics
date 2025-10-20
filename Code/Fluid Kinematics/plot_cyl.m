function plot_cyl()

theta = (0:200)/200'*2*pi;
xc = 0.5*sin(theta);
yc = 0.5*cos(theta);
fill(xc,yc,0.5*[1 1 1])
hold on
plot(xc,yc,'k','LineWidth',1)
hold off

end