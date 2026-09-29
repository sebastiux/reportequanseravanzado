---
layout: default
title: Ganancias del observador
nav_order: 4
---

# Cálculo de ganancias para el Observador de Estados
{: .no_toc }

Entregable 3: demostración y diseño de las ganancias del observador para garantizar la estabilidad y convergencia del error de estimación de cada estado (por ejemplo $$\hat\theta - \theta$$).

1. TOC
{:toc}

---

## 1) Condición de observabilidad

$$
\mathcal{O} = \begin{bmatrix} C \\ CA \\ CA^2 \\ CA^3 \end{bmatrix}, \qquad \operatorname{rango}(\mathcal{O}) = 4
$$

_Pendiente: resultado numérico y conclusión._

## 2) Dinámica del error de estimación

Definiendo el error $$e = x - \hat x$$:

$$
\dot e = (A - LC)\, e
$$

El error converge a cero si todos los valores propios de $$A - LC$$ tienen parte real negativa.

_Pendiente: demostración completa a partir de las ecuaciones del observador (ver [Ecuaciones del observador]({{ '/04-ecuaciones-observador/' | relative_url }}))._

## 3) Selección de polos del observador

_Pendiente: criterio (p. ej. polos entre 3 y 10 veces más rápidos que los del lazo LQR) y método (asignación de polos por dualidad `place(A', C', p)'` o LQE/Kalman)._

| Estado | Polo del controlador | Polo del observador |
|:-------|:--------------------:|:-------------------:|
| $$\theta_p$$ | _Pendiente_ | _Pendiente_ |
| $$\theta_y$$ | _Pendiente_ | _Pendiente_ |
| $$\dot\theta_p$$ | _Pendiente_ | _Pendiente_ |
| $$\dot\theta_y$$ | _Pendiente_ | _Pendiente_ |

## 4) Ganancia resultante

$$
L = \begin{bmatrix}
l_{11} & l_{12} \\
l_{21} & l_{22} \\
l_{31} & l_{32} \\
l_{41} & l_{42}
\end{bmatrix} = \text{Pendiente}
$$

| Propiedad | Resultado |
|:----------|:----------|
| eig$$(A - LC)$$ | _Pendiente_ |
| Tiempo de convergencia del error | _Pendiente_ |

---

## Siguiente sección

[Ecuaciones del observador de estados]({{ '/04-ecuaciones-observador/' | relative_url }})
