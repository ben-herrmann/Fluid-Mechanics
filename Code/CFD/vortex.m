function omg = vortex(x,y,x0,y0,gamma,r0)

ny = length(y); nx = length(x);
Lx = x(nx)-x(1)+(x(2)-x(1));
Ly = y(ny)-y(1)+(y(2)-y(1));
omg = zeros(ny,nx);
for i = -1:1
    for j = -1:1 % making sure to add periodic images
        r2  = (x-x0-i*Lx).^2 + (y'-y0-j*Ly).^2;
        omg = omg + gamma/(pi*r0^2)*exp(-r2/r0^2);
    end
end

end