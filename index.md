---
layout: default
title: Inicio
nav_order: 1
description: "Control LQR y observador de estados implementados en la plataforma Quanser Aero 2."
---

<p class="report-kicker">Proyecto práctico · Control Avanzado y Robótica · Otoño 2026</p>

# Control LQR y Observador de Estados en el Quanser Aero 2
{: .fs-8 }

<p class="report-lead">Diseño, simulación e implementación de un regulador cuadrático lineal acoplado a un observador de estados para regular los ángulos de cabeceo (<em>pitch</em>) y guiñada (<em>yaw</em>) de un helicóptero de dos grados de libertad.</p>

[Ver el reporte en PDF]({{ '/assets/files/reporte-aero2.pdf' | relative_url }}){: .btn .btn-primary .mr-2 }
[Ir al modelado]({{ '/01-modelado/' | relative_url }}){: .btn }

<div class="report-meta">
  <div><span class="report-meta__label">Equipo</span><span class="report-meta__value">Diego Márquez Aleman<br>Jesús Emanuel Velázquez Pérez<br>Carlos Sebastián Ortega Hernández<br>Kevin</span></div>
  <div><span class="report-meta__label">Docentes</span><span class="report-meta__value">Dr. Andrés Guillermo Molano Jiménez<br>Mtro. Julio Antonio Caballero Mora</span></div>
  <div><span class="report-meta__label">Plataforma</span><span class="report-meta__value">Quanser Aero 2 (Equipo A)<br>MATLAB · Simulink · QUARC</span></div>
  <div><span class="report-meta__label">Presentación</span><span class="report-meta__value">2 de octubre de 2026</span></div>
</div>

---

## Resumen

Se diseñó e implementó un esquema de control por retroacción de estados basado en un **Regulador Cuadrático Lineal (LQR)**, complementado con un **observador de estados**, para estabilizar la plataforma experimental Quanser Aero 2.

El trabajo partió de la validación del modelo linealizado en espacio de estados, verificando su controlabilidad y observabilidad. Después se diseñó el LQR seleccionando las matrices de ponderación $$Q$$ y $$R$$ y resolviendo la Ecuación Algebraica de Riccati en MATLAB. Con el controlador funcionando, se dedujeron las ecuaciones del observador a partir del diagrama de bloques del proyecto y se asignaron sus polos por igualación de coeficientes. Finalmente, controlador y observador se integraron en Simulink y se implementaron en la planta física, sustituyendo las velocidades calculadas por Quanser por las velocidades estimadas.

<div class="kpi-grid">
  <div class="kpi"><span class="kpi__value">4 / 4</span><span class="kpi__label">Rango de controlabilidad / observabilidad</span></div>
  <div class="kpi"><span class="kpi__value">500 / 80</span><span class="kpi__label">Pesos de θp / θy en Q</span></div>
  <div class="kpi"><span class="kpi__value">0.02 I₂</span><span class="kpi__label">Matriz de esfuerzo R</span></div>
  <div class="kpi"><span class="kpi__value">p = 100</span><span class="kpi__label">Polo triple del observador</span></div>
  <div class="kpi"><span class="kpi__value">±24 V</span><span class="kpi__label">Saturación de los motores</span></div>
</div>

## Objetivos

**Objetivo general.** Diseñar e implementar un sistema de control por retroacción de estados mediante un LQR acoplado a un observador de estados para el Quanser Aero 2, garantizando la regulación y estabilidad de los ángulos de *pitch* y *yaw* aun con perturbaciones, así como la correcta estimación de las variables no medidas.

**Objetivos particulares.**

1. **Diseño y sintonización del LQR.** Calcular la matriz de ganancias $$K_{lqr}$$ minimizando la función de costo cuadrática, justificando $$Q$$ y $$R$$ para equilibrar velocidad de respuesta y límites de voltaje de los motores.
2. **Deducción e implementación del observador.** Obtener analíticamente las ecuaciones del observador a partir del diagrama de bloques e igualar su polinomio característico con uno deseado para calcular las ganancias $$(\beta, l, m)$$.
3. **Simulación y validación experimental.** Integrar control y estimación en MATLAB/Simulink, analizando la respuesta en lazo cerrado, la convergencia de las estimaciones ($$\hat x$$ vs. $$x$$) y el desempeño ante perturbaciones.

## Contenido

<div class="chapter-grid">
  <a class="chapter-card" href="{{ '/01-modelado/' | relative_url }}">
    <span class="chapter-card__num">01</span>
    <span class="chapter-card__text"><strong>Modelado del sistema</strong><small>Espacio de estados, parámetros, controlabilidad y observabilidad</small></span>
  </a>
  <a class="chapter-card" href="{{ '/02-control-lqr/' | relative_url }}">
    <span class="chapter-card__num">02</span>
    <span class="chapter-card__text"><strong>Control LQR</strong><small>Selección de Q y R, ganancia K y pruebas en planta</small></span>
  </a>
  <a class="chapter-card" href="{{ '/03-ecuaciones-observador/' | relative_url }}">
    <span class="chapter-card__num">03</span>
    <span class="chapter-card__text"><strong>Ecuaciones del observador</strong><small>Deducción a partir del diagrama de bloques</small></span>
  </a>
  <a class="chapter-card" href="{{ '/04-ganancias-observador/' | relative_url }}">
    <span class="chapter-card__num">04</span>
    <span class="chapter-card__text"><strong>Ganancias del observador</strong><small>Polinomio característico y asignación de polos</small></span>
  </a>
  <a class="chapter-card" href="{{ '/05-resultados/' | relative_url }}">
    <span class="chapter-card__num">05</span>
    <span class="chapter-card__text"><strong>Resultados y discusión</strong><small>Integración en lazo cerrado, video y conclusiones</small></span>
  </a>
  <a class="chapter-card" href="{{ '/06-programas-y-video/' | relative_url }}">
    <span class="chapter-card__num">06</span>
    <span class="chapter-card__text"><strong>Programas y video</strong><small>Scripts de MATLAB, modelos de Simulink y evidencia</small></span>
  </a>
</div>

## Plataforma experimental

<figure class="report-figure">
  <img src="{{ '/assets/img/aero2/aero2.jpg' | relative_url }}" alt="Plataforma Quanser Aero 2 con dos rotores sobre un soporte pivotado" style="width: 100%; max-width: 420px;">
  <figcaption><strong>Figura 1.</strong> Plataforma experimental Quanser Aero 2 (helicóptero de 2 DOF).</figcaption>
</figure>

El Quanser Aero 2 es un sistema aerodinámico de laboratorio de dos grados de libertad, configurado para emular la dinámica de un helicóptero. Consta de dos rotores impulsados por motores de corriente directa montados en un cuerpo basculante sobre un soporte central pivotado. La implementación en tiempo real se realiza con MATLAB/Simulink y QUARC: el modelo lee las posiciones angulares de los *encoders* y envía los voltajes de control $$V_p$$ y $$V_y$$ a la planta.

| Elemento | Definición |
|:---------|:-----------|
| Vector de estados | $$x = [\theta_p,\ \theta_y,\ \dot\theta_p,\ \dot\theta_y]^T$$ |
| Entradas de control | $$u = [V_p,\ V_y]^T$$ — voltajes de los motores de cabeceo y guiñada |
| Salidas medidas | $$y = [\theta_p,\ \theta_y]^T$$ — ángulos medidos por los *encoders* |

<nav class="page-nav">
  <a class="page-nav__next" href="{{ '/01-modelado/' | relative_url }}"><small>Siguiente</small>01 · Modelado del sistema →</a>
</nav>
