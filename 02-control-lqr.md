---
layout: default
title: Control LQR
nav_order: 3
---

<p class="report-kicker">Entregable 2 · Primera parte</p>

# Cálculo de la ganancia K para el LQR
{: .no_toc }

Selección de las matrices de ponderación, solución de la ecuación de Riccati y validación del regulador en simulación y en la planta física.
{: .fs-5 .fw-300 }

<details open markdown="block">
  <summary>Contenido</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## 1. Fundamento teórico

El Regulador Cuadrático Lineal es una técnica de control óptimo por retroacción estática de estados para sistemas LTI de la forma $$\dot x = Ax + Bu$$. Busca la ley de control

$$
u(t) = -K_{lqr}\, x(t) \tag{7}
$$

que minimiza el funcional de costo cuadrático en horizonte infinito

$$
J = \int_0^{\infty} \left( x^T Q\, x + u^T R\, u \right) dt \tag{8}
$$

| Matriz | Propiedad | Qué penaliza |
|:------:|:----------|:-------------|
| $$Q \in \mathbb{R}^{4\times4}$$ | Simétrica, semidefinida positiva | Desviación de los estados respecto a la referencia |
| $$R \in \mathbb{R}^{2\times2}$$ | Simétrica, definida positiva | Energía y agresividad de los voltajes de control |

La ganancia óptima se obtiene como

$$
K_{lqr} = R^{-1} B^T P \tag{9}
$$

donde $$P$$ es la única solución simétrica definida positiva de la Ecuación Algebraica de Riccati (ARE):

$$
A^T P + P A - P B R^{-1} B^T P + Q = 0 \tag{10}
$$

{: .note }
Aumentar los elementos de la diagonal de $$Q$$ acelera el asentamiento de los estados correspondientes; aumentar $$R$$ penaliza el voltaje y suaviza la acción de control. El diseño es un compromiso entre velocidad de respuesta y saturación de los actuadores.

## 2. Selección de Q y R

### Matriz de estados Q

Inicialmente se ponderaron los cuatro estados. Durante las pruebas se observó que el desempeño mejoraba al **concentrar la ponderación en las posiciones angulares** y dejar sin ponderación directa las velocidades, que quedan reguladas indirectamente por el acoplamiento dinámico. Se asignó mayor peso al cabeceo, el eje con dinámica oscilatoria y más sensible a perturbaciones:

$$
Q = \operatorname{diag}(500,\ 80,\ 0,\ 0) \tag{11}
$$

### Matriz de esfuerzo R

| Iteración | $$R$$ | Observación |
|:---------:|:-----:|:------------|
| 1 | $$I_{2\times2}$$ | La respuesta de los motores fue insuficiente para alcanzar el comportamiento deseado. |
| 2 (final) | $$0.02\, I_{2\times2}$$ | Respuesta suficientemente rápida sin superar los límites de los actuadores. |

$$
R = 0.02\, I_{2\times2} \tag{12}
$$

{: .warning }
Se consideró el rango de operación de los motores (aprox. 5 a 24 V) y se fijó una **saturación de ±24 V** en Simulink para proteger la planta.

## 3. Cálculo de la ganancia

```matlab
%% Parámetros nominales del Quanser Aero 2
Ksp = 0.0130;      Jp = 0.0231885;   Dp = 0.00266;
Dy  = 0.00175;     Jy = 0.0238104;   Dt = 0.16743;
Kpp = 0.00323;     Kpy = 0.00149;
Kyy = 0.00571;     Kyp = -0.00235;

%% Modelo linealizado en espacio de estados
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

%% Diseño LQR
Q = diag([500 80 0 0]);   % prioridad a las posiciones angulares
R = 0.02*eye(2);          % penalización del voltaje

K_lqr = lqr(A_modelo, B_modelo, Q, R)     % resuelve la ARE
polos_lazo_cerrado = eig(A_modelo - B_modelo*K_lqr)
```

Con los parámetros nominales y las ponderaciones finales se obtiene:

$$
K_{lqr} = \begin{bmatrix}
125.92 & -25.45 & 91.24 & -21.43 \\
55.90 & 57.90 & 39.02 & 47.74
\end{bmatrix} \tag{13}
$$

| Polos en lazo cerrado $$\operatorname{eig}(A - BK_{lqr})$$ | Valor |
|:-----------------------------------------------------------|:------|
| Par 1 | $$-1.332 \pm 1.526i$$ |
| Par 2 | $$-1.171 \pm 1.171i$$ |

{: .result }
Todos los polos tienen parte real negativa, por lo que el lazo cerrado es **asintóticamente estable**. Comparado con el lazo abierto (parte real −0.057 y un polo en el origen), los polos se desplazaron más de una década a la izquierda; el polo dominante sugiere un tiempo de asentamiento teórico de $$t_s \approx 4/1.17 \approx 3.4\ \text{s}$$ (sin considerar saturación).

{: .note }
Con $$R = I$$ los polos quedan en $$-0.35 \pm 0.82i$$ y $$-0.44 \pm 0.44i$$, unas tres veces más lentos, lo que coincide con la respuesta insuficiente observada en la primera iteración.

## 4. Implementación y pruebas iniciales

El controlador se probó primero **sin el observador**, usando el estado que genera la arquitectura de Quanser (ángulos de los *encoders* y velocidades obtenidas con un filtro pasabajas de segundo orden). Así se validó la ley de control antes de introducir estimaciones.

La referencia fue $$\theta_{p,\,ref} = 0$$ y $$\theta_{y,\,ref} = 0$$. Como el origen se establece a partir de la posición física de la planta al iniciar, fue posible probar el controlador desde distintas posiciones iniciales y ante perturbaciones manuales.

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/simulink-lqr.png' | relative_url }}" alt="Diagrama de Simulink con el bloque de ganancias LQR, saturación de ±24 V, escritura HIL al Aero 2 y modelo en espacio de estados en paralelo">
  <figcaption><strong>Figura 2.</strong> Implementación del controlador LQR en Simulink. El error entre el estado deseado $$x_d$$ y el estado actual pasa por las ganancias LQR y una saturación de ±24 V antes de escribirse en la planta; el modelo en espacio de estados corre en paralelo para comparación.</figcaption>
</figure>

### Proceso de ajuste

1. Construcción del modelo con los parámetros nominales.
2. Propuesta de $$Q$$ y $$R$$ según la prioridad de cada estado y los límites de actuación.
3. Solución de la ARE con `lqr` para obtener $$K_{lqr}$$.
4. Verificación de la estabilidad con los polos en lazo cerrado.
5. Pruebas iterativas en la planta real ajustando $$Q$$ y $$R$$ hasta que el helicóptero estabilizó sus ángulos ante perturbaciones manuales y siguió las referencias impuestas.

<nav class="page-nav">
  <a href="{{ '/01-modelado/' | relative_url }}"><small>Anterior</small>← 01 · Modelado</a>
  <a class="page-nav__next" href="{{ '/03-ecuaciones-observador/' | relative_url }}"><small>Siguiente</small>03 · Ecuaciones del observador →</a>
</nav>
