clear variables; close all; clc;

a = linspace(0,1,100);
Cp = 4*a.*(1-a).^2;
Ct = 4*a.*(1-a);

figure(1)
plot(a,Cp,'r-',a,Ct,'b-','LineWidth',1.4)
xlabel('Axial induction factor, a'), ylabel('Thrust and power coefficients')
legend('CP','CT','Location','northeast')
fontsize(18,'points'), fontname('Times')
ylim([0,1.1])
grid on
pbaspect([3 2 1])
set(gcf,'Color','w')

saveas(gcf,'betz.png')