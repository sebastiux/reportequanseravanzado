---
layout: default
title: Control LQR
nav_order: 3
---

# Cálculo de ganancias K para LQR
{: .no_toc }

Entregable 2: proceso de ajuste de las matrices de ponderación y cálculo de la ganancia $$K$$ de la retroacción LQR.

1. TOC
{:toc}

---

## 1) Planteamiento

El LQR calcula la ley de control $$u = -K(x - x_{ref})$$ que minimiza

$$
J = \int_0^{\infty} \left( x^T Q\, x + u^T R\, u \right) dt
$$

donde $$Q$$ pondera el error de los estados y $$R$$ la agresividad del esfuerzo de control de los motores. La ganancia se obtiene de la ecuación algebraica de Riccati:

$$
A^T P + P A - P B R^{-1} B^T P + Q = 0, \qquad K = R^{-1} B^T P
$$

_Pendiente: explicar cómo se incorporan las referencias de $$\theta_p$$ y $$\theta_y$$ (y acción integral, si se usa)._

## 2) Selección de Q y R

_Pendiente: criterio de ajuste (p. ej. regla de Bryson, iteración en simulación, límites de voltaje de los motores)._

| Iteración | $$Q$$ | $$R$$ | Observaciones |
|:---------:|:------|:------|:--------------|
| 1 | _Pendiente_ | _Pendiente_ | _Pendiente_ |
| 2 | _Pendiente_ | _Pendiente_ | _Pendiente_ |
| Final | _Pendiente_ | _Pendiente_ | _Pendiente_ |

## 3) Ganancia resultante

$$
K = \begin{bmatrix}
k_{11} & k_{12} & k_{13} & k_{14} \\
k_{21} & k_{22} & k_{23} & k_{24}
\end{bmatrix} = \text{Pendiente}
$$

| Propiedad | Resultado |
|:----------|:----------|
| Polos en lazo cerrado eig$$(A - BK)$$ | _Pendiente_ |
| Tiempo de establecimiento (cabeceo / guiñada) | _Pendiente_ |
| Sobreimpulso (cabeceo / guiñada) | _Pendiente_ |
| Voltaje máximo aplicado | _Pendiente_ |

## 4) Implementación

_Pendiente: diagrama de Simulink del lazo LQR en `assets/img/aero2/simulink-lqr.png` y descripción de los bloques._

![Diagrama Simulink LQR]({{ '/assets/img/aero2/simulink-lqr.png' | relative_url }})

Código: [`codigo/matlab/`](https://github.com/sebastiux/reportequanseravanzado/tree/main/codigo/matlab)

---

## Siguiente sección

[Cálculo de ganancias del observador]({{ '/03-ganancias-observador/' | relative_url }})
