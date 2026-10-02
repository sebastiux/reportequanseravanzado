%% diseno_observador.m
% Cálculo de las ganancias (beta, l, m) del observador de estados por
% igualación de coeficientes con un polo triple en s = -p.
% Control Avanzado y Robótica - Otoño 2026
%
% Ecuaciones del observador (deducidas del diagrama de bloques):
%   e         = theta - theta_hat
%   dalpha    = e - beta*alpha
%   ddtheta   = l*e + m*alpha
% Estados: [theta_hat; dtheta_hat; alpha]. Entrada: theta medido.

clear; clc;
syms s l beta m p

%% Matriz del observador
A_obs = [ 0  1  0;
         -l  0  m;
         -1  0 -beta];
B_obs = [0; l; 1];

%% Polinomio característico: s^3 + beta*s^2 + l*s + (l*beta + m)
P_obs = collect(det(s*eye(3) - A_obs), s)

%% Polinomio deseado: polo triple en -p
P_des = expand((s + p)^3)

%% Igualación de coeficientes
eq1 = beta       == 3*p;      % s^2
eq2 = l          == 3*p^2;    % s^1
eq3 = l*beta + m == p^3;      % s^0
sol = solve([eq1, eq2, eq3], [beta, l, m]);

%% Ubicación final (ajustada experimentalmente en la planta)
p_final  = 100;
beta_val = double(subs(sol.beta, p, p_final))   % 300
l_val    = double(subs(sol.l,    p, p_final))   % 30000
m_val    = double(subs(sol.m,    p, p_final))   % -8000000

%% Verificación: los tres polos deben quedar en -p_final
A_num = double(subs(A_obs, [beta l m], [beta_val l_val m_val]));
polos_observador = eig(A_num)
