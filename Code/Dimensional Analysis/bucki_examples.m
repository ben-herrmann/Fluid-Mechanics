clear variables; close all; clc;

% F [M L T^-2]
% U [L T^-1]
% mu [M L^-1 T^-1]
% rho [M L^-3]
% c [L]

% Matrix of dimension exponents D
%  | U c rho|
% —————–-—––—
% M| 0 0  1 | 
% L| 1 1 -3 |
% T|-1 0  0 |

% Matrix of dimension exponents B
%  | F mu|
% ————————
% M| 1  1| 
% L| 1 -1|
% T|-2 -1|

D = [0 0 1;
     1 1 -3;
     0 -1 0];

B = [1 1;
     1 -1;
     -2 -1];

X = D\B

%% 
clear variables; close all; clc;

% E [M L^2 T^-2]
% t [T]
% rho [M L^-3]
% D [L]

D = [0 1 0;
     1 -3 0;
     0 0 1];
b = [1; 2; -2];

x = D\b
