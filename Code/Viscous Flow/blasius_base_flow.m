function U = blasius_base_flow(Nx,Ny,x0,xend,yhalf,Ly)

[x,y] = bl_grid(Nx,Ny,x0,xend,yhalf,Ly);
n = 10001;
eta = linspace(0,20,n)';
d2f0 = fsolve(@(x) blasius_cost(x),0.332);
[~,X] = ode78(@(eta,x) blasius_rhs(x),eta,[0;0;d2f0]);
Udata = X(:,2);
ydata= sqrt(x'/x0).*eta/4.91;

U = zeros(Ny,Nx);
for i=1:Nx
    U(:,i) = interp1(ydata(:,i),Udata,y,'cubic');
    U(isnan(U(:,i)),i) = 1;
end

U = U(:);

end