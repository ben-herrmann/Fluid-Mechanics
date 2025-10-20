clear variables; close all; clc

% Define parameters and constants
nu = 1e-6;
Lx = 1;
Ly = 1;

% Set up grid and computational domain
nx = 256;
ny = 256;
x = linspace(-Lx/2,Lx/2,nx+1); x = x(1:nx);
y = linspace(-Ly/2,Ly/2,ny+1); y = y(1:ny);
n = nx*ny;

% Dynamics
f = ns2d_solver_dealiased(nu,x,y);
% f = ns2d_solver(nu,Lx,Ly,nx,ny);

% Initial condition
% omg0 = 100*real(ifft2(randn(ny,nx)));
% omg0 = omg0 - mean(omg0(:));
omg0 = -exp(-450*(y'-0.01*sin(2*pi*(x+Lx/2)/Lx)).^2); % shear layer
% omg0 = zeros(ny,nx);
% for i=1:4000
%     x0 = Lx*(rand(1)-0.5);
%     y0 = Ly*(rand(1)-0.5);
%     gamma = 5e-4*(randi(3)-2);
%     r0 = 0.01;
%     vtx = vortex(x,y,x0,y0,gamma,r0);
%     omg0 = omg0 + vtx;
% end
% omg0 = omg0 - mean(omg0(:));
% vtx = @(x0,y0)vortex(x,y,x0,y0,1e-2,0.05);
% omg0 = vtx(-0.07,0) + vtx(0.07,0); % vortex merger
% omg0 = vtx(-0.07,0) - vtx(0.07,0); % vortex dipole
% omg0 = vtx(-0.4,0.1) - vtx(-0.4,-0.1)...
%       +vtx(-0.1,0.15) - vtx(-0.1,-0.15); % leapfroging
% omg0 = vtx(-0.07,-0.4) - vtx(0.07,-0.4)...
%        -vtx(-0.07,0.4) + vtx(0.07,0.40); % dipole colission

% Plot initial condition
lim = max(abs(omg0(:)));
pcolor(x,y,omg0), shading interp, axis equal, axis tight
xlabel('$x$','Interpreter','LaTeX','FontSize',18)
ylabel('$y$','Interpreter','LaTeX','FontSize',18)
set(gca,'FontName','Times','FontSize',16)
colormap jet; colorbar();
clim([-0.5*lim,0.5*lim]);
%%
% Time discretization
m = 301;
tf = 300;
t = linspace(0,tf,m);

% Solve in spectral space!
omghat0 = reshape(fft2(omg0),n,1); % fft of initial condition
tic
[t,Omg] = ode45(f,t,omghat0);
Omg = transpose(Omg);
toc

%% Animate solution

figure(1)
colormap bone
% colormap redblue(1000)
for i=1:m
    omg = real(ifft2(reshape(Omg(:,i),ny,nx)));
    pcolor(x,y,omg), shading interp, axis equal, axis tight
    xlabel('$x$','Interpreter','LaTeX','FontSize',18)
    ylabel('$y$','Interpreter','LaTeX','FontSize',18)
    set(gca,'FontName','Times','FontSize',16)
    set(gcf,'Color','w')
    xticks(-0.4:0.2:0.4), yticks(-0.4:0.2:0.4)
    % clim(0.1*[-lim,lim])
    cbar = colorbar(); 
    title 'Vorticity, \omega';
    % pause(0.1);
    drawnow
end

%% Save animation

close all;

% Create video file
disp('Creating video file...');
video_dir = 'random_vortices_bone';
myVideo = VideoWriter(video_dir,'MPEG-4'); %open video file
myVideo.FrameRate = 30;
open(myVideo)

figure(1)
colormap bone
for i=1:m
    omg = real(ifft2(reshape(Omg(:,i),ny,nx)));
    pcolor(x,y,omg), shading interp, axis equal, axis tight
    xlabel('$x$','Interpreter','LaTeX','FontSize',18,'Color','w')
    ylabel('$y$','Interpreter','LaTeX','FontSize',18,'Color','w')
    set(gca,'FontName','Times','FontSize',16,'xcolor','w','ycolor','w')
    set(gcf,'Color','k','InvertHardcopy','off');
    xticks(-0.4:0.2:0.4), yticks(-0.4:0.2:0.4)
    drawnow()

    % Write frame to video
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end

close(myVideo)
disp('Video saved!');