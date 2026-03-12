# Análisis Exploratorio y Proyección de Comportamiento Comercial

Análisis del comportamiento de ventas retail desde la extracción y limpieza de datos hasta la proyección de demanda futura. El proyecto cubre todo el flujo: SQL para estructurar y validar los datos, Python para el análisis exploratorio y el modelado predictivo.

---

## Objetivo

Identificar tendencias, patrones por periodo, categoría y producto, y proyectar el comportamiento futuro de las ventas para orientar decisiones de inventario y planificación comercial.

---

## Dataset

Sample Superstore — dataset público de ventas retail con información de pedidos, clientes, productos y geografía.  
Fuente: [Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)  
Período: 2014 – 2017 | 9,994 registros

---

## Estructura del repositorio

```
├── data/
│   ├── raw/               # Dataset original sin modificar
│   └── processed/         # Datos limpios y resúmenes exportados
├── images/                # Visualizaciones generadas por el notebook
├── sql/
│   ├── 01_create_tables.sql   # Creación de tablas en SQL Server
│   ├── 02_cleaning.sql        # Validaciones y limpieza
│   └── 03_kpis.sql            # Indicadores clave de negocio
├── src/
│   └── analysis.ipynb         #  principal: EDA, visualizaciones y proyección
└── README.md
```

---

## Flujo del proyecto

**1. SQL Server**  
Creación de tablas relacionales para clientes, productos y ventas. Validaciones de calidad: nulos, duplicados, fechas inconsistentes, registros huérfanos. Consultas para generar indicadores por mes, categoría, segmento y región.

**2. Python — Análisis exploratorio**  
Carga y limpieza con Pandas: conversión de fechas, estandarización de texto, detección de outliers con IQR. Visualizaciones con Matplotlib y Seaborn: tendencia mensual, comparativa por categoría, impacto del descuento en el margen.

**3. Python — Proyección**  
Regresión lineal con Scikit-learn para proyectar ingresos 6 meses hacia adelante. Serie temporal con promedios móviles de 3 y 6 meses. Cálculo de variación mensual (MoM) para detectar picos y caídas.

---

## Visualizaciones

| Gráfico | Descripción |
|---|---|
| <img width="1440" height="480" alt="01_outliers_boxplot" src="https://github.com/user-attachments/assets/b7eb02d1-a0dd-416d-9e35-883339be7d31" /> | Distribución de Sales y Profit con outliers |
| <img width="1680" height="480" alt="02_monthly_trend" src="https://github.com/user-attachments/assets/c7909de4-4d6c-4008-8456-85769b214a5f" />  | Ingresos y beneficio mensual |
| <img width="1680" height="600" alt="03_category_analysis" src="https://github.com/user-attachments/assets/18850fe3-443f-4991-aa98-1460c98c9098" /> | Ingresos y margen por subcategoría |
| <img width="1440" height="480" alt="04_segment_region" src="https://github.com/user-attachments/assets/e9de62ed-f308-4ee1-b7a5-9e57058e8523" /> | Comparativa por segmento y región |
|<img width="960" height="480" alt="05_discount_vs_profit" src="https://github.com/user-attachments/assets/63c82cf0-c1c6-4d63-b051-1a3abd68bc37" /> | Relación entre descuento y beneficio |
| <img width="1680" height="480" alt="06_linear_forecast" src="https://github.com/user-attachments/assets/4a5b9812-8778-442c-ab92-ed729350de61" /> | Proyección de ingresos con regresión lineal |
|<img width="1680" height="480" alt="07_moving_average" src="https://github.com/user-attachments/assets/6c3a0020-b9f6-412b-a6d0-93132234ada8" /> | Serie temporal con promedios móviles |
| <img width="1680" height="360" alt="08_mom_variation" src="https://github.com/user-attachments/assets/e0f2f7e2-3b5b-4539-ab43-79d3073f718d" /> | Variación mensual de ingresos (MoM %) |

---

## Principales hallazgos

- Las subcategorías con mayor descuento promedio (Tables, Bookcases) presentan margen negativo.
- El segmento Consumer genera el mayor volumen de ingresos pero Corporate tiene mejor ticket promedio.
- La región West concentra la mayor rentabilidad; Central muestra los márgenes más ajustados.
- La tendencia general de ingresos es positiva con picos recurrentes en el último trimestre de cada año.

---

## Stack tecnológico

`Python` `Pandas` `NumPy` `Scikit-learn` `Matplotlib` `Seaborn` `SQL Server`
