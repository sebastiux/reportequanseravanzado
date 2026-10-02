---
layout: default
title: Resultados y discusión
nav_order: 6
---

<p class="report-kicker">Entregable 5</p>

# Análisis y discusión de resultados
{: .no_toc }

Integración del controlador LQR con el observador en lazo cerrado, evidencia experimental en el Quanser Aero 2 y discusión de los resultados.
{: .fs-5 .fw-300 }

<details open markdown="block">
  <summary>Contenido</summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## 1. Metodología de integración

La integración se realizó de forma incremental para aislar posibles fallas en cada etapa:

| Etapa | Estado que recibe el LQR | Propósito |
|:-----:|:-------------------------|:----------|
| 1. LQR solo | Ángulos de los *encoders* + velocidades del filtro de Quanser | Validar la ley de control ([sección 02]({{ '/02-control-lqr/' | relative_url }}#4-implementación-y-pruebas-iniciales)) |
| 2. Observador en paralelo | Igual que la etapa 1; el observador solo se monitorea | Comparar $$\hat\theta$$ contra $$\theta$$ sin arriesgar la estabilidad |
| 3. Lazo con observador | Ángulos de los *encoders* + **velocidades estimadas** | Sustituir el cálculo de velocidades de Quanser por el observador |

En la configuración final el vector de estados que usa el controlador es

$$
x = \begin{bmatrix} \theta_p & \theta_y & \dot{\hat\theta}_p & \dot{\hat\theta}_y \end{bmatrix}^T \tag{26}
$$

es decir, una ley de control basada en las **posiciones medidas** y las **velocidades estimadas**.

## 2. Observador en paralelo

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/simulink-lqr-observador-paralelo.png' | relative_url }}" alt="Diagrama de Simulink con el lazo LQR original y el observador conectado en paralelo a las señales Pitch y Yaw">
  <figcaption><strong>Figura 5.</strong> Etapa 2: el observador se ejecuta en paralelo, alimentado por las señales <code>[Pitch]</code> y <code>[Yaw]</code>, mientras el lazo LQR sigue cerrado con el filtro de Quanser. Los osciloscopios comparan cada estimación con su medición.</figcaption>
</figure>

En esta etapa se verificó que las estimaciones de ambos ejes convergieran a las mediciones y que la velocidad estimada fuera coherente con la del filtro de Quanser antes de usarla en el control.

## 3. Lazo cerrado con observador

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/simulink-lazo-final.png' | relative_url }}" alt="Diagrama final de Simulink con los subsistemas Planta y Observador; las velocidades estimadas se conectan al vector de estado del LQR">
  <figcaption><strong>Figura 6.</strong> Etapa 3: arquitectura final. El subsistema <em>Observador</em> entrega \(\dot{\hat\theta}_p\) y \(\dot{\hat\theta}_y\), que sustituyen a las velocidades del bloque de Quanser en el vector de estado que entra a las ganancias LQR.</figcaption>
</figure>

Los bloques nativos de Quanser que calculaban y filtraban las velocidades angulares se desacoplaron del lazo. Finalmente se ajustó en la planta real la posición de los polos del observador para mejorar el rechazo a perturbaciones y garantizar la estabilidad del helicóptero en operación continua.

## 4. Evidencia experimental

<figure class="report-figure">
  <div class="responsive-embed">
    <iframe src="https://www.youtube.com/embed/Ow0opi5Q_fY?rel=0" title="Quanser Aero 2: LQR con observador de estados" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen loading="lazy"></iframe>
  </div>
  <figcaption><strong>Video 1.</strong> Implementación en la plataforma Quanser Aero 2: lecturas del observador contra las mediciones reales, con el LQR en lazo cerrado mediante el observador.</figcaption>
</figure>

## 5. Resumen de resultados

| Aspecto | Resultado |
|:--------|:----------|
| Controlabilidad / observabilidad | Rango 4 en ambas matrices: sistema completamente controlable y observable |
| Ponderaciones LQR | $$Q = \operatorname{diag}(500, 80, 0, 0)$$, $$R = 0.02\,I_2$$ |
| Polos en lazo cerrado (LQR) | $$-1.33 \pm 1.53i$$, $$-1.17 \pm 1.17i$$ |
| Ganancias del observador | $$\beta = 300$$, $$l = 30\,000$$, $$m = -8\,000\,000$$ |
| Polos del observador | Triple en $$s = -100$$ |
| Saturación de actuadores | ±24 V |
| Comportamiento en planta | Estable ante perturbaciones manuales, usando velocidades estimadas |

## 6. Discusión

**Efecto de Q y R.** Concentrar la ponderación en las posiciones angulares, con mayor peso en el cabeceo, priorizó la regulación de los ángulos que se miden directamente. Reducir $$R$$ de $$I$$ a $$0.02\,I$$ fue determinante: con $$R = I$$ los polos en lazo cerrado quedaban unas tres veces más lentos y los motores no entregaban suficiente empuje. Con las ponderaciones finales se redujeron las oscilaciones observadas en las pruebas preliminares sin rebasar los límites de los actuadores.

**Velocidad del observador.** La regla convencional de colocar los polos del observador una década más rápido que los del controlador produjo oscilaciones en las estimaciones. El modelo lineal no captura las dinámicas de alta frecuencia ni las no linealidades aerodinámicas de los rotores, por lo que la ubicación final ($$p = 100$$) se obtuvo experimentalmente. Esto ilustra que el diseño analítico es el punto de partida, pero la sintonización final depende de la planta real.

**Diferencias entre modelo y planta.** El diseño se hizo con los parámetros nominales del fabricante. Las diferencias de amortiguamiento, el acoplamiento entre ejes y las incertidumbres del montaje explican por qué fue necesario iterar sobre $$Q$$, $$R$$ y $$p$$ en la plataforma.

### Limitaciones y trabajo futuro

- Identificar experimentalmente los parámetros del Aero 2 para reducir la discrepancia con el modelo nominal.
- Cuantificar el desempeño (tiempo de asentamiento, sobreimpulso, error RMS de estimación) a partir de datos registrados en las pruebas.
- Agregar acción integral al LQR para eliminar el error en estado estacionario ante perturbaciones constantes.
- Comparar el observador propuesto con un observador de Luenberger completo o un filtro de Kalman.

## 7. Conclusiones

El proyecto permitió implementar un esquema de control por retroacción de estados basado en LQR junto con un observador de estados en el Quanser Aero 2. A partir del modelo linealizado se obtuvieron las matrices en espacio de estados y se verificaron la controlabilidad y la observabilidad, condiciones necesarias para el diseño del controlador y del observador.

La selección de $$Q$$ y $$R$$ tuvo un efecto directo en la respuesta: las ponderaciones finales priorizaron la regulación de los ángulos de *pitch* y *yaw* y mantuvieron el esfuerzo de control dentro de los límites de operación, logrando estabilizar la planta ante perturbaciones.

El observador sustituyó el cálculo directo de las velocidades angulares por estimaciones obtenidas de las posiciones medidas. Mediante la igualación de coeficientes se obtuvieron $$\beta = 300$$, $$l = 30\,000$$ y $$m = -8\,000\,000$$, con un ajuste experimental hasta $$p = 100$$. La integración del observador con el LQR permitió operar la plataforma con estados estimados, lo que demuestra la importancia de considerar tanto el modelo matemático como las no linealidades de la planta física al diseñar y ajustar un sistema de control.

## Referencias

1. MATLAB. *What is Linear Quadratic Regulator (LQR) Optimal Control? — State Space, Part 4*. YouTube, 2019.
2. A. G. Molano Jiménez y J. A. Caballero Mora. *Proyecto práctico – Control Avanzado y Robótica*. Universidad Iberoamericana, Ciudad de México, septiembre 2026.
3. Quanser Inc. *Aero 2 User Manual*, v2.1, diciembre 2022.
4. Quanser Inc. *Quanser Academic Resources*, 2026.
5. Quanser Inc. *Quanser Aero 2 – QUARC Data Acquisition Card Support*, 2026.
6. Universidad Iberoamericana. *Apuntes de Control Avanzado*, 2023.

<nav class="page-nav">
  <a href="{{ '/04-ganancias-observador/' | relative_url }}"><small>Anterior</small>← 04 · Ganancias del observador</a>
  <a class="page-nav__next" href="{{ '/06-programas-y-video/' | relative_url }}"><small>Siguiente</small>06 · Programas y video →</a>
</nav>
