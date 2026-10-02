---
layout: default
title: Ecuaciones del observador
nav_order: 4
---

<p class="report-kicker">Entregable 4 · Segunda parte</p>

# Definición de las ecuaciones del observador de estados
{: .no_toc }

Deducción de las ecuaciones dinámicas del observador a partir del diagrama de bloques del proyecto y su representación matricial en espacio de estados.
{: .fs-5 .fw-300 }

<details open markdown="block">
  <summary>Contenido</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## 1. ¿Por qué un observador?

La ley $$u = -K_{lqr}\,x$$ requiere el vector de estado completo en cada instante. En el Aero 2 solo se miden los ángulos con los *encoders*; las velocidades angulares no se miden y, si se obtienen derivando numéricamente, amplifican el ruido de medición.

Un **observador de estados** es un sistema dinámico secundario que, a partir de las mediciones de la planta, genera una estimación $$\hat x(t)$$ de las variables internas. Como el par $$(A, C)$$ es completamente observable ([sección 01]({{ '/01-modelado/' | relative_url }}#6-observabilidad)), es posible diseñarlo de modo que el error de estimación converja a cero con la velocidad deseada.

{: .important }
De acuerdo con el planteamiento del proyecto, el observador está acoplado **únicamente a la salida medida** de la planta: no recibe el comando de control. Solo estima los estados que después utiliza la ley LQR.

## 2. Diagrama de bloques

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/diagrama-observador.png' | relative_url }}" alt="Diagrama de bloques del observador con tres integradores y ganancias l, beta y m">
  <figcaption><strong>Figura 3.</strong> Observador de estados propuesto en el proyecto. La entrada es el ángulo medido \(\theta\); las salidas son el ángulo estimado \(\hat\theta\) y la velocidad estimada \(\dot{\hat\theta}\).</figcaption>
</figure>

## 3. Definición de estados

Se definen tres estados del observador, uno por cada integrador del diagrama:

$$
x_1 = \theta, \qquad x_2 = \dot\theta, \qquad x_3 = \alpha \tag{14}
$$

donde $$\alpha$$ es el estado interno del lazo de corrección (salida del tercer integrador), que acumula el error de estimación y actúa como término integral sobre la aceleración estimada.

## 4. Deducción de las ecuaciones por estado

Siguiendo las señales del diagrama de izquierda a derecha:

**Error de estimación.** El primer sumador compara la medición con la estimación:

$$
e = \theta - \hat\theta \tag{15}
$$

**Lazo de corrección.** El segundo sumador resta la realimentación $$\beta\,\hat\alpha$$ al error, y el resultado se integra:

$$
\dot{\hat\alpha} = e - \beta\,\hat\alpha \tag{16}
$$

**Aceleración estimada.** El último sumador combina el error escalado por $$l$$ y el estado $$\hat\alpha$$ escalado por $$m$$; esa señal entra a la cadena de dos integradores:

$$
\ddot{\hat\theta} = l\,e + m\,\hat\alpha \tag{17}
$$

Sustituyendo (15) y expresando todo en términos de los estados estimados $$\hat x_1 = \hat\theta$$, $$\hat x_2 = \dot{\hat\theta}$$, $$\hat x_3 = \hat\alpha$$:

$$
\begin{aligned}
\dot{\hat x}_1 &= \hat x_2 \\
\dot{\hat x}_2 &= -l\,\hat x_1 + m\,\hat x_3 + l\,\theta \\
\dot{\hat x}_3 &= -\hat x_1 - \beta\,\hat x_3 + \theta
\end{aligned} \tag{18}
$$

## 5. Representación matricial

Las ecuaciones (18) se escriben como $$\dot{\hat x} = A_{obs}\,\hat x + B_{obs}\,\theta$$, con

$$
A_{obs} = \begin{bmatrix}
0 & 1 & 0 \\
-l & 0 & m \\
-1 & 0 & -\beta
\end{bmatrix}, \qquad
B_{obs} = \begin{bmatrix} 0 \\ l \\ 1 \end{bmatrix}, \qquad
C_{obs} = \begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \end{bmatrix} \tag{19}
$$

donde $$C_{obs}$$ entrega las dos señales que usa el controlador: $$\hat\theta$$ y $$\dot{\hat\theta}$$.

### Función de transferencia

Aplicando la transformada de Laplace a (15)–(17) se obtiene la relación entre el ángulo medido y su estimación:

$$
\frac{\hat\Theta(s)}{\Theta(s)} = \frac{l\,s + (l\beta + m)}{s^3 + \beta s^2 + l\,s + (l\beta + m)} \tag{20}
$$

$$
\frac{E(s)}{\Theta(s)} = \frac{s^2\,(s + \beta)}{s^3 + \beta s^2 + l\,s + (l\beta + m)} \tag{21}
$$

{: .note }
La ganancia en estado estacionario de (20) es 1, y el error (21) tiene un doble cero en el origen: el observador sigue sin error en estado estacionario un ángulo constante **y** un ángulo que cambia a velocidad constante. Por eso $$\dot{\hat\theta}$$ es una estimación confiable de la velocidad angular.

## 6. Aplicación a los dos ejes

El mismo observador se aplica de forma independiente a cada eje: uno recibe $$\theta_p$$ (*pitch*) y otro $$\theta_y$$ (*yaw*). En Simulink se implementó vectorizado, con las señales `[Pitch]` y `[Yaw]` multiplexadas, de modo que un solo diagrama produce las estimaciones de ambos ejes.

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/simulink-observador.png' | relative_url }}" alt="Implementación del observador en Simulink con integradores y ganancias l, beta y m">
  <figcaption><strong>Figura 4.</strong> Implementación del observador en Simulink: integradores \(1/s\), ganancias \(l\), \(\beta\) y \(m\), y comparación de la estimación con la medición en un osciloscopio.</figcaption>
</figure>

<nav class="page-nav">
  <a href="{{ '/02-control-lqr/' | relative_url }}"><small>Anterior</small>← 02 · Control LQR</a>
  <a class="page-nav__next" href="{{ '/04-ganancias-observador/' | relative_url }}"><small>Siguiente</small>04 · Ganancias del observador →</a>
</nav>
