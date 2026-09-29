---
layout: default
title: Descripción y modelado
nav_order: 2
---

# Descripción y modelado del sistema
{: .no_toc }

Entregable 1: modelado y demostración paso a paso de la dinámica linealizada en el espacio de estados.

1. TOC
{:toc}

---

## 1) Descripción del sistema

_Pendiente: describir el Aero 2 (configuración de 2 DOF, rotores, sensores, convención de signos de $$\theta_p$$ y $$\theta_y$$)._

![Diagrama de cuerpo libre]({{ '/assets/img/aero2/dcl.png' | relative_url }})

_Pendiente: diagrama de cuerpo libre en `assets/img/aero2/dcl.png`._

## 2) Ecuaciones de movimiento

_Pendiente: plantear las ecuaciones de cabeceo y guiñada a partir de los pares que actúan sobre el cuerpo._

$$
J_p\,\ddot\theta_p + D_p\,\dot\theta_p + K_{sp}\,\theta_p = \tau_p
$$

$$
J_y\,\ddot\theta_y + D_y\,\dot\theta_y = \tau_y
$$

_Pendiente: expresar $$\tau_p$$ y $$\tau_y$$ en función de $$V_p$$ y $$V_y$$ (empuje directo y cruzado)._

## 3) Linealización y representación en espacio de estados

Con el vector de estados $$x = [\theta_p,\ \theta_y,\ \dot\theta_p,\ \dot\theta_y]^T$$ y entradas $$u = [V_p,\ V_y]^T$$:

$$
\dot x = A x + B u, \qquad y = C x + D u
$$

$$
A = \begin{bmatrix}
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 \\
-\dfrac{K_{sp}}{J_p} & 0 & -\dfrac{D_p}{J_p} & 0 \\
0 & 0 & 0 & -\dfrac{D_y}{J_y}
\end{bmatrix}, \qquad
B = \begin{bmatrix}
0 & 0 \\
0 & 0 \\
\dfrac{D_t K_{pp}}{J_p} & \dfrac{D_t K_{py}}{J_p} \\
\dfrac{D_t K_{yp}}{J_y} & \dfrac{D_t K_{yy}}{J_y}
\end{bmatrix}
$$

$$
C = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \end{bmatrix}, \qquad
D = \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}
$$

_Pendiente: demostración paso a paso (punto de operación, supuestos de ángulo pequeño, términos despreciados)._

## 4) Parámetros del sistema

Parámetros nominales del fabricante. La columna **Identificado** se llena con los valores obtenidos en las prácticas de laboratorio previas.

| Descripción | Símbolo | Nominal | Identificado | Unidades |
|:------------|:-------:|--------:|-------------:|:---------|
| Distancia del pivote al centro del rotor | $$D_t$$ | 0.16743 | _Pendiente_ | m |
| Masa total del cuerpo aerodinámico | $$M_b$$ | 1.07 | _Pendiente_ | kg |
| Distancia del plano al centro de masa inf. | $$D_m$$ | 2.4×10⁻³ | _Pendiente_ | m |
| Momento de inercia (cabeceo) | $$J_p$$ | 0.0231885 | _Pendiente_ | kg·m² |
| Momento de inercia (guiñada) | $$J_y$$ | 0.0238104 | _Pendiente_ | kg·m² |
| Gravedad | $$g$$ | 9.81 | — | m/s² |
| Rigidez (cabeceo) | $$K_{sp}$$ | 0.0130 | _Pendiente_ | N·m/V |
| Amortiguamiento (cabeceo) | $$D_p$$ | 0.00266 | _Pendiente_ | N·m/V |
| Ganancia de empuje de cabeceo | $$K_{pp}$$ | 0.00323 | _Pendiente_ | N/V |
| Empuje cruzado (cabeceo desde guiñada) | $$K_{py}$$ | 0.00149 | _Pendiente_ | N/V |
| Amortiguamiento (guiñada) | $$D_y$$ | 0.00175 | _Pendiente_ | N·m/V |
| Ganancia de empuje de guiñada | $$K_{yy}$$ | 0.00571 | _Pendiente_ | N/V |
| Empuje cruzado (guiñada desde cabeceo) | $$K_{yp}$$ | −0.00235 | _Pendiente_ | N/V |

_Pendiente: describir cómo se validaron los parámetros (prueba, datos, error respecto al nominal)._

## 5) Matrices numéricas y análisis del modelo

_Pendiente: matrices $$A$$ y $$B$$ evaluadas con los parámetros validados._

| Propiedad | Resultado |
|:----------|:----------|
| Polos en lazo abierto (eig$$(A)$$) | _Pendiente_ |
| Rango de la matriz de controlabilidad | _Pendiente_ (debe ser 4) |
| Rango de la matriz de observabilidad | _Pendiente_ (debe ser 4) |

---

## Siguiente sección

[Cálculo de ganancias K (LQR)]({{ '/02-control-lqr/' | relative_url }})
