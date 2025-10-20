function fhandle = plot_cylinder_flow(x,y,q)

s = pcolor(x,y,q);
set(s,'FaceColor','interp','EdgeColor','none');
% yellow, red, black, blue, cyan
colors = [1 1 0; 1 0 0; 0 0 0; 0 0 1; 0 1 1];
colors_fine = interp1(0:0.25:1,colors,linspace(0,1,128));
colormap(colors_fine);
xticks([]); yticks([]);
daspect([1 1 1]);
set(gcf,'Color','w');
fhandle = gcf;
axis off; axis tight;

hold on;
t = (0:200)/200'*2*pi;
xc = 0.5*sin(t);
yc = 0.5*cos(t);
fill(xc,yc,0.5*[1 1 1])
plot(xc,yc,'w','LineWidth',0.8)
xlim([-3,15]); ylim([-3,3])
hold off;
end