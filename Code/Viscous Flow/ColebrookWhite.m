function f = ColebrookWhite(eps_rel,Re)

if Re < 2300
    f = 64/Re;
else
    F = @(f) 1/sqrt(f) + 2*log10(eps_rel/3.7+2.51/(Re*sqrt(f)));
    f_guess = 0.1;
    f = fsolve(F,f_guess);
end

end