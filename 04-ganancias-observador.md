---
layout: default
title: Ganancias del observador
nav_order: 5
---

<p class="report-kicker">Entregable 3 · Segunda parte</p>

# Cálculo de las ganancias del observador
{: .no_toc }

Asignación de polos por igualación de coeficientes para garantizar la estabilidad y la convergencia del error de estimación $$\hat\theta - \theta$$.
{: .fs-5 .fw-300 }

<details open markdown="block">
  <summary>Contenido</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## 1. Polinomio característico del observador

La estabilidad del observador y la convergencia del error dependen de los valores propios de $$A_{obs}$$ ([ecuación 19]({{ '/03-ecuaciones-observador/' | relative_url }}#5-representación-matricial)). Su polinomio característico se obtiene de $$\det(sI - A_{obs})$$:

$$
sI - A_{obs} = \begin{bmatrix}
s & -1 & 0 \\
l & s & -m \\
1 & 0 & s + \beta
\end{bmatrix}
$$

Desarrollando por la primera fila:

$$
\det(sI - A_{obs}) = s\left[s(s+\beta)\right] + 1\left[l(s+\beta) + m\right]
$$

$$
P_{obs}(s) = s^3 + \beta\, s^2 + l\, s + (l\beta + m) \tag{22}
$$

## 2. Polinomio deseado

Se eligió colocar los tres polos del observador en un mismo punto estable $$s = -p$$:

$$
P_{des}(s) = (s + p)^3 = s^3 + 3p\, s^2 + 3p^2 s + p^3 \tag{23}
$$

Con la ubicación final $$p = 100$$:

$$
P_{des}(s) = (s + 100)^3 = s^3 + 300\, s^2 + 30\,000\, s + 1\,000\,000 \tag{24}
$$

## 3. Igualación de coeficientes

Igualando (22) con (24) término a término:

| Potencia | $$P_{obs}(s)$$ | $$P_{des}(s)$$ | Ecuación |
|:--------:|:--------------:|:--------------:|:---------|
| $$s^2$$ | $$\beta$$ | $$3p = 300$$ | $$\beta = 300$$ |
| $$s^1$$ | $$l$$ | $$3p^2 = 30\,000$$ | $$l = 30\,000$$ |
| $$s^0$$ | $$l\beta + m$$ | $$p^3 = 1\,000\,000$$ | $$m = p^3 - l\beta$$ |

De la última fila:

$$
m = 1\,000\,000 - (30\,000)(300) = 1\,000\,000 - 9\,000\,000 = -8\,000\,000
$$

<div class="kpi-grid">
  <div class="kpi"><span class="kpi__value">β = 300</span><span class="kpi__label">Realimentación del lazo de corrección</span></div>
  <div class="kpi"><span class="kpi__value">l = 30 000</span><span class="kpi__label">Ganancia sobre el error de estimación</span></div>
  <div class="kpi"><span class="kpi__value">m = −8 000 000</span><span class="kpi__label">Ganancia del estado α</span></div>
</div>

En forma general, para cualquier $$p$$:

$$
\beta = 3p, \qquad l = 3p^2, \qquad m = p^3 - 9p^3 = -8p^3 \tag{25}
$$

{: .result }
Con estas ganancias los tres valores propios de $$A_{obs}$$ están en $$s = -100$$. El error de estimación es asintóticamente estable y converge en aproximadamente $$t_s \approx 4/100 = 0.04\ \text{s}$$, unas 85 veces más rápido que el polo dominante del lazo LQR ($$-1.17$$).

## 4. Cálculo en MATLAB

```matlab
syms s l beta m p

% Matriz del observador deducida del diagrama de bloques
A_obs = [ 0  1  0;
         -l  0  m;
         -1  0 -beta];

% Polinomio característico: s^3 + beta*s^2 + l*s + (l*beta + m)
P_obs = collect(det(s*eye(3) - A_obs), s)

% Polinomio deseado con polo triple en -p
P_des = expand((s + p)^3)

% Igualación de coeficientes término a término
eq1 = beta         == 3*p;      % s^2
eq2 = l            == 3*p^2;    % s^1
eq3 = l*beta + m   == p^3;      % s^0
sol = solve([eq1, eq2, eq3], [beta, l, m]);

% Evaluación para la ubicación final
p_final = 100;
beta_val = double(subs(sol.beta, p, p_final))   % 300
l_val    = double(subs(sol.l,    p, p_final))   % 30000
m_val    = double(subs(sol.m,    p, p_final))   % -8000000
```

## 5. Ajuste experimental de los polos

La ubicación de los polos no se limitó al procedimiento analítico; el observador debía validarse en la planta física.

| Etapa | Criterio | Resultado en la planta |
|:-----:|:---------|:-----------------------|
| 1 | Regla empírica: polos del observador ~10 veces más rápidos que los polos dominantes del LQR | Oscilaciones persistentes en las estimaciones, causadas por las dinámicas de alta frecuencia y las no linealidades del sistema aerodinámico |
| 2 (final) | Ajuste experimental manteniendo el polo triple, hasta $$p = 100$$ | Estimaciones estables que convergen adecuadamente y pueden alimentar la ley LQR |

{: .warning }
Un observador más rápido sigue mejor la medición, pero también deja pasar más ruido de los *encoders*. La elección de $$p = 100$$ fue el mejor compromiso observado entre convergencia y rechazo de ruido en esta plataforma.

<nav class="page-nav">
  <a href="{{ '/03-ecuaciones-observador/' | relative_url }}"><small>Anterior</small>← 03 · Ecuaciones del observador</a>
  <a class="page-nav__next" href="{{ '/05-resultados/' | relative_url }}"><small>Siguiente</small>05 · Resultados y discusión →</a>
</nav>
