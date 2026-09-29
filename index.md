---
layout: default
title: Proyecto y equipo
nav_order: 1
---

# Control LQR y Observador de Estados — Quanser Aero 2

**Control Avanzado y Robótica · Otoño 2026**  
**Profesores:** Dr. Andrés Guillermo Molano Jiménez, Mtro. Julio Antonio Caballero Mora  
**Equipo A — Plataforma Quanser Aero 2**  
**Integrantes:** _Nombre 1_, _Nombre 2_, _Nombre 3_

Contenido:
- [1. Proyecto y equipo](#descripción-del-proyecto) (esta página)
- [2. Descripción y modelado del sistema]({{ '/01-modelado/' | relative_url }})
- [3. Cálculo de ganancias K (LQR)]({{ '/02-control-lqr/' | relative_url }})
- [4. Cálculo de ganancias del observador]({{ '/03-ganancias-observador/' | relative_url }})
- [5. Ecuaciones del observador de estados]({{ '/04-ecuaciones-observador/' | relative_url }})
- [6. Análisis y discusión de resultados]({{ '/05-resultados/' | relative_url }})
- [7. Programas y video]({{ '/06-programas-y-video/' | relative_url }})

> Estado: **plantilla**. Las secciones marcadas con _Pendiente_ se completan conforme avance el proyecto.

---

## Descripción del proyecto

El proyecto se divide en dos partes sobre la plataforma **Quanser Aero 2**, un helicóptero de **2 grados de libertad** (cabeceo / *pitch* y guiñada / *yaw*):

1. **Control LQR:** diseñar e implementar un control por retroacción de estados que regule los ángulos de cabeceo y guiñada hacia un conjunto de referencias deseadas, minimizando una función de costo con las matrices de ponderación $$Q$$ y $$R$$.
2. **Observador de Estados:** diseñar e implementar un observador acoplado a la **salida medida** de la planta (sin información del comando) que estime los estados usados por la ley de control LQR.

### Objetivos

- Diseñar controladores óptimos (LQR) y observadores para sistemas lineales en el espacio de estados, e implementarlos con tecnología electrónica digital.
- Usar las herramientas de espacio de estados para plantear esquemas de control y observadores robustos para sistemas lineales y linealizados.
- Documentar el trabajo en un repositorio estructurado y defenderlo en una evaluación oral.

### Plataforma

![Quanser Aero 2]({{ '/assets/img/aero2/aero2.jpg' | relative_url }})

_Pendiente: agregar foto de la plataforma en `assets/img/aero2/aero2.jpg`._

| Elemento | Descripción |
|:---------|:------------|
| Estados | $$x = [\theta_p,\ \theta_y,\ \dot\theta_p,\ \dot\theta_y]^T$$ |
| Entradas | Voltaje del motor de cabeceo $$V_p$$ y de guiñada $$V_y$$ |
| Salidas medidas | Ángulos $$\theta_p$$ y $$\theta_y$$ (encoders) |
| Entorno | MATLAB / Simulink + QUARC _(confirmar versión)_ |

### Entregables

| # | Entregable | Sección |
|--:|:-----------|:--------|
| 1 | Modelado y demostración paso a paso de la dinámica linealizada | [Modelado]({{ '/01-modelado/' | relative_url }}) |
| 2 | Ajuste de $$Q$$, $$R$$ y cálculo de la ganancia $$K$$ | [Control LQR]({{ '/02-control-lqr/' | relative_url }}) |
| 3 | Diseño de las ganancias del observador | [Ganancias del observador]({{ '/03-ganancias-observador/' | relative_url }}) |
| 4 | Ecuaciones del observador para cada estado | [Ecuaciones del observador]({{ '/04-ecuaciones-observador/' | relative_url }}) |
| 5 | Gráficas de estados y estimaciones, análisis y discusión | [Resultados]({{ '/05-resultados/' | relative_url }}) |
| — | Programas comentados y video del sistema físico | [Programas y video]({{ '/06-programas-y-video/' | relative_url }}) |

**Presentación:** viernes 2 de octubre de 2026, sesión de laboratorio.

---

## Siguiente sección

[Descripción y modelado del sistema]({{ '/01-modelado/' | relative_url }})
