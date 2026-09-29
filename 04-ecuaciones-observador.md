---
layout: default
title: Ecuaciones del observador
nav_order: 5
---

# Definición de ecuaciones del Observador de Estados
{: .no_toc }

Entregable 4: obtención de las ecuaciones que definen al observador para cada estado a partir del diagrama del proyecto.

1. TOC
{:toc}

---

## 1) Diagrama del observador

El observador está acoplado a la **salida medida** de la planta; no recibe información del comando y solo estima los estados que usa la ley de control LQR.

![Diagrama del observador]({{ '/assets/img/aero2/diagrama-observador.png' | relative_url }})

_Pendiente: diagrama (Figura 3 del proyecto o versión propia) en `assets/img/aero2/diagrama-observador.png`._

## 2) Ecuación matricial

_Pendiente: derivar la forma matricial a partir del diagrama._

$$
\dot{\hat x} = A \hat x + L\,(y - C \hat x), \qquad u = -K \hat x
$$

## 3) Ecuaciones por estado

_Pendiente: desarrollar cada fila de la ecuación matricial._

$$
\dot{\hat\theta}_p = \text{Pendiente}
$$

$$
\dot{\hat\theta}_y = \text{Pendiente}
$$

$$
\ddot{\hat\theta}_p = \text{Pendiente}
$$

$$
\ddot{\hat\theta}_y = \text{Pendiente}
$$

## 4) Implementación en Simulink

![Diagrama Simulink del observador]({{ '/assets/img/aero2/simulink-observador.png' | relative_url }})

_Pendiente: captura del subsistema del observador y descripción de sus bloques (integradores, condiciones iniciales, tiempo de muestreo)._

---

## Siguiente sección

[Análisis y discusión de resultados]({{ '/05-resultados/' | relative_url }})
