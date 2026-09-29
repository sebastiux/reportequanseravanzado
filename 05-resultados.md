---
layout: default
title: Resultados
nav_order: 6
---

# Análisis y discusión de resultados
{: .no_toc }

Entregable 5: gráficas de los estados y su estimación bajo distintos escenarios, discutiendo la relación entre las métricas de control y las metodologías empleadas.

1. TOC
{:toc}

---

## 1) Escenarios de prueba

| # | Escenario | Referencia $$\theta_p$$ / $$\theta_y$$ | Entorno |
|--:|:----------|:---------------------------------------:|:--------|
| 1 | LQR con estados medidos | _Pendiente_ | Simulación / Aero 2 |
| 2 | LQR con estados estimados (observador) | _Pendiente_ | Simulación / Aero 2 |
| 3 | Perturbación externa | _Pendiente_ | Aero 2 |
| 4 | _Pendiente_ | _Pendiente_ | _Pendiente_ |

## 2) Control LQR

_Pendiente: gráficas de $$\theta_p$$, $$\theta_y$$ contra la referencia y voltajes $$V_p$$, $$V_y$$._

![Respuesta LQR]({{ '/assets/img/aero2/resultados-lqr.png' | relative_url }})

## 3) Observador de estados

_Pendiente: gráficas de cada estado contra su estimación y del error de estimación ($$\hat\theta - \theta$$)._

![Estados y estimaciones]({{ '/assets/img/aero2/resultados-observador.png' | relative_url }})

## 4) Métricas

| Métrica | Simulación | Aero 2 (físico) |
|:--------|:----------:|:---------------:|
| Tiempo de establecimiento $$\theta_p$$ | _Pendiente_ | _Pendiente_ |
| Tiempo de establecimiento $$\theta_y$$ | _Pendiente_ | _Pendiente_ |
| Sobreimpulso $$\theta_p$$ / $$\theta_y$$ | _Pendiente_ | _Pendiente_ |
| Error en estado estacionario | _Pendiente_ | _Pendiente_ |
| Error RMS de estimación | _Pendiente_ | _Pendiente_ |
| Voltaje máximo | _Pendiente_ | _Pendiente_ |

## 5) Discusión

_Pendiente:_
- _Relación entre la elección de $$Q$$, $$R$$ y el desempeño obtenido._
- _Efecto de los polos del observador en la respuesta del lazo cerrado._
- _Diferencias entre simulación y planta física (parámetros, ruido, saturación)._
- _Limitaciones y mejoras propuestas._

## 6) Conclusiones

_Pendiente._

---

## Siguiente sección

[Programas y video]({{ '/06-programas-y-video/' | relative_url }})
