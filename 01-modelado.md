---
layout: default
title: Modelado del sistema
nav_order: 2
---

<p class="report-kicker">Entregable 1</p>

# Descripción y modelado del sistema
{: .no_toc }

Modelo linealizado del Quanser Aero 2 en espacio de estados, parámetros físicos y verificación de las propiedades que hacen posible el diseño del controlador y del observador.
{: .fs-5 .fw-300 }

<details open markdown="block">
  <summary>Contenido</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## 1. Representación en espacio de estados

Un sistema lineal e invariante en el tiempo (LTI) se describe mediante un conjunto de ecuaciones diferenciales de primer orden:

$$
\dot x = A x + B u, \qquad y = C x + D u \tag{1}
$$

donde $$x$$ es el vector de estados, $$u$$ el vector de entradas, $$y$$ el vector de salidas y $$A, B, C, D$$ las matrices que describen la dinámica. Para el Aero 2 se definen:

| Vector | Componentes | Descripción |
|:-------|:------------|:------------|
| Estados $$x$$ | $$[\theta_p,\ \theta_y,\ \dot\theta_p,\ \dot\theta_y]^T$$ | Ángulos y velocidades angulares de cabeceo y guiñada |
| Entradas $$u$$ | $$[V_p,\ V_y]^T$$ | Voltaje de los motores de cabeceo y guiñada |
| Salidas $$y$$ | $$[\theta_p,\ \theta_y]^T$$ | Ángulos medidos por los *encoders* |

## 2. Modelo linealizado

Las matrices del sistema linealizado en tiempo continuo, en función de los parámetros físicos, son:

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
\end{bmatrix} \tag{2}
$$

$$
C = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \end{bmatrix}, \qquad
D = \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix} \tag{3}
$$

Las dos primeras filas de $$A$$ expresan que las velocidades son las derivadas de los ángulos. La tercera fila corresponde a la dinámica de cabeceo, con rigidez $$K_{sp}$$ y amortiguamiento $$D_p$$; la cuarta, a la guiñada, que solo presenta amortiguamiento $$D_y$$ (no hay par restaurador). La matriz $$B$$ incluye los **empujes cruzados** $$K_{py}$$ y $$K_{yp}$$, que acoplan ambos ejes: cada motor afecta tanto al cabeceo como a la guiñada.

## 3. Parámetros del sistema

Se utilizaron los parámetros nominales del fabricante (Cuadro 1 del proyecto):

| Descripción | Símbolo | Valor | Unidades |
|:------------|:-------:|------:|:---------|
| Distancia del pivote al centro del rotor | $$D_t$$ | 0.16743 | m |
| Masa total del cuerpo aerodinámico | $$M_b$$ | 1.07 | kg |
| Distancia del plano al centro de masa inferior | $$D_m$$ | 2.4 × 10⁻³ | m |
| Momento de inercia (cabeceo) | $$J_p$$ | 0.0231885 | kg·m² |
| Momento de inercia (guiñada) | $$J_y$$ | 0.0238104 | kg·m² |
| Gravedad | $$g$$ | 9.81 | m/s² |
| Rigidez (cabeceo) | $$K_{sp}$$ | 0.0130 | N·m/V |
| Amortiguamiento (cabeceo) | $$D_p$$ | 0.00266 | N·m/V |
| Ganancia de empuje de cabeceo | $$K_{pp}$$ | 0.00323 | N/V |
| Empuje cruzado (cabeceo desde guiñada) | $$K_{py}$$ | 0.00149 | N/V |
| Amortiguamiento (guiñada) | $$D_y$$ | 0.00175 | N·m/V |
| Ganancia de empuje de guiñada | $$K_{yy}$$ | 0.00571 | N/V |
| Empuje cruzado (guiñada desde cabeceo) | $$K_{yp}$$ | −0.00235 | N/V |

## 4. Matrices numéricas

Sustituyendo los parámetros en (2) se obtiene el modelo evaluado en el punto de operación:

$$
A = \begin{bmatrix}
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 \\
-0.5606 & 0 & -0.1147 & 0 \\
0 & 0 & 0 & -0.0735
\end{bmatrix}, \qquad
B = \begin{bmatrix}
0 & 0 \\
0 & 0 \\
0.0233 & 0.0108 \\
-0.0165 & 0.0402
\end{bmatrix} \tag{4}
$$

El modelo se integró en Simulink como un bloque de espacio de estados en paralelo a la planta física para comparar su comportamiento en lazo abierto antes de aplicar cualquier acción de control. La respuesta del modelo resultó consistente con la de la plataforma, lo que permitió avanzar al diseño del controlador y del estimador.

## 5. Controlabilidad

La controlabilidad indica si es posible llevar los estados del sistema a cualquier valor mediante las entradas. Para un sistema de orden $$n$$:

$$
\mathcal{C} = \begin{bmatrix} B & AB & A^2B & \cdots & A^{n-1}B \end{bmatrix}, \qquad \operatorname{rango}(\mathcal{C}) = n \tag{5}
$$

```matlab
Co = ctrb(A_modelo, B_modelo);
rank(Co)   % = 4
```

{: .result }
El rango de la matriz de controlabilidad es $$4 = n$$, por lo que el modelo es **completamente controlable**; es posible implementar la retroacción de estados.

## 6. Observabilidad

La observabilidad indica si los estados internos pueden reconstruirse a partir de las salidas medidas:

$$
\mathcal{O} = \begin{bmatrix} C \\ CA \\ CA^2 \\ \vdots \\ CA^{n-1} \end{bmatrix}, \qquad \operatorname{rango}(\mathcal{O}) = n \tag{6}
$$

```matlab
Ob = obsv(A_modelo, C);
rank(Ob)   % = 4
```

{: .result }
El rango de la matriz de observabilidad es $$4 = n$$, por lo que el modelo es **completamente observable** con las salidas definidas por $$C$$; las velocidades angulares pueden estimarse a partir de los ángulos medidos.

## 7. Polos en lazo abierto

Los valores propios de $$A$$ (`eig(A_modelo)`) describen la dinámica del modelo antes de aplicar la retroacción:

| Polo | Valor | Interpretación |
|:----:|:------|:---------------|
| $$\lambda_{1,2}$$ | $$-0.0574 \pm 0.7465i$$ | Cabeceo: modo oscilatorio muy poco amortiguado ($$\zeta \approx 0.08$$) |
| $$\lambda_3$$ | $$0$$ | Guiñada: integrador puro (sin par restaurador) |
| $$\lambda_4$$ | $$-0.0735$$ | Guiñada: amortiguamiento viscoso, respuesta muy lenta |

{: .note }
El polo en el origen hace que la guiñada sea marginalmente estable en lazo abierto, y el modo de cabeceo tarda decenas de segundos en asentarse. Ambos motivan el uso de un controlador por retroacción de estados.

<nav class="page-nav">
  <a href="{{ '/' | relative_url }}"><small>Anterior</small>← Inicio</a>
  <a class="page-nav__next" href="{{ '/02-control-lqr/' | relative_url }}"><small>Siguiente</small>02 · Control LQR →</a>
</nav>
