clear variables; close all; clc

eps_rel = 0.0;
Re = 7e4;

F = @(f) 1/sqrt(f) + 2*log10(eps_rel/3.7+2.51/(Re*sqrt(f)));

f_guess = 0.1;
f = fsolve(F,f_guess)