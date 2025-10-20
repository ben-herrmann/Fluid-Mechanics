function J = blasius_cost(d2f0)

x0 = [0;0;d2f0];
[~,X] = ode78(@(eta,x) blasius_rhs(x),[0,20],x0);
J = X(end,2)-1;

end