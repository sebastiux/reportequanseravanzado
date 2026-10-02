%% diseno_lqr.m
% Modelo linealizado del Quanser Aero 2 y diseño del regulador LQR.
% Control Avanzado y Robótica - Otoño 2026
%
% Estados:  x = [theta_p; theta_y; dtheta_p; dtheta_y]
% Entradas: u = [Vp; Vy]   (voltajes de los motores de cabeceo y guiñada)
% Salidas:  y = [theta_p; theta_y]

clear; clc;

%% Parámetros nominales del fabricante
Ksp = 0.0130;       % Rigidez (cabeceo)                      [N*m/V]
Jp  = 0.0231885;    % Momento de inercia (cabeceo)           [kg*m^2]
Dp  = 0.00266;      % Amortiguamiento (cabeceo)              [N*m/V]
Dy  = 0.00175;      % Amortiguamiento (guiñada)              [N*m/V]
Jy  = 0.0238104;    % Momento de inercia (guiñada)           [kg*m^2]
Dt  = 0.16743;      % Distancia del pivote al centro del rotor [m]
Kpp = 0.00323;      % Ganancia de empuje de cabeceo          [N/V]
Kpy = 0.00149;      % Empuje cruzado (cabeceo desde guiñada) [N/V]
Kyy = 0.00571;      % Ganancia de empuje de guiñada          [N/V]
Kyp = -0.00235;     % Empuje cruzado (guiñada desde cabeceo) [N/V]

%% Modelo en espacio de estados
A_modelo = [0        0  1       0;
            0        0  0       1;
           -Ksp/Jp   0 -Dp/Jp   0;
            0        0  0      -Dy/Jy];

B_modelo = [0           0;
            0           0;
            Dt*Kpp/Jp   Dt*Kpy/Jp;
            Dt*Kyp/Jy   Dt*Kyy/Jy];

C = [1 0 0 0;
     0 1 0 0];
D = zeros(2);

%% Propiedades del modelo
polos_lazo_abierto = eig(A_modelo)
rango_controlabilidad = rank(ctrb(A_modelo, B_modelo))   % debe ser 4
rango_observabilidad  = rank(obsv(A_modelo, C))          % debe ser 4

%% Diseño LQR
Q = diag([500 80 0 0]);   % se ponderan solo las posiciones angulares
R = 0.02*eye(2);          % penalización del voltaje (R = I resultó lento)

K_lqr = lqr(A_modelo, B_modelo, Q, R)                    % resuelve la ARE
polos_lazo_cerrado = eig(A_modelo - B_modelo*K_lqr)

%% Límite de los actuadores usado en Simulink
V_sat = 24;   % saturación de +/-24 V
