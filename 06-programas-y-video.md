---
layout: default
title: Programas y video
nav_order: 7
---

<p class="report-kicker">Evidencia</p>

# Programas y video
{: .no_toc }

Código fuente comentado, modelos de Simulink y evidencia del sistema funcionando en el laboratorio.
{: .fs-5 .fw-300 }

---

## Programas

| Archivo | Descripción |
|:--------|:------------|
| [`codigo/matlab/diseno_lqr.m`](https://github.com/sebastiux/reportequanseravanzado/blob/main/codigo/matlab/diseno_lqr.m) | Parámetros, matrices del modelo, controlabilidad, observabilidad y cálculo de $$K_{lqr}$$ |
| [`codigo/matlab/diseno_observador.m`](https://github.com/sebastiux/reportequanseravanzado/blob/main/codigo/matlab/diseno_observador.m) | Polinomio característico, igualación de coeficientes y cálculo de $$\beta$$, $$l$$ y $$m$$ |
| [`codigo/simulink/`](https://github.com/sebastiux/reportequanseravanzado/tree/main/codigo/simulink) | Modelos de Simulink/QUARC del lazo LQR y del observador |

{: .note }
Ejecuta primero `diseno_lqr.m` y `diseno_observador.m` para cargar en el *workspace* las variables `K_lqr`, `beta_val`, `l_val` y `m_val` que usan los modelos de Simulink.

## Video del sistema funcionando

<figure class="report-figure">
  <div class="responsive-embed">
    <iframe src="https://www.youtube.com/embed/Ow0opi5Q_fY?rel=0" title="Quanser Aero 2: LQR con observador de estados" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen loading="lazy"></iframe>
  </div>
  <figcaption><strong>Video 1.</strong> LQR en lazo cerrado mediante el observador de estados en el Quanser Aero 2.</figcaption>
</figure>

[Ver en YouTube](https://www.youtube.com/watch?v=Ow0opi5Q_fY){: .btn .mr-2 }
[Descargar reporte en PDF]({{ '/assets/files/reporte-aero2.pdf' | relative_url }}){: .btn .btn-primary }

<nav class="page-nav">
  <a href="{{ '/05-resultados/' | relative_url }}"><small>Anterior</small>← 05 · Resultados y discusión</a>
</nav>
