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
│   └── analysis.ipynb         # Notebook principal: EDA, visualizaciones y proyección
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
| `01_outliers_boxplot.png` | Distribución de Sales y Profit con outliers |
| `02_monthly_trend.png` | Ingresos y beneficio mensual |
| `03_category_analysis.png` | Ingresos y margen por subcategoría |
| `04_segment_region.png` | Comparativa por segmento y región |
| `05_discount_vs_profit.png` | Relación entre descuento y beneficio |
| `06_linear_forecast.png` | Proyección de ingresos con regresión lineal |
| `07_moving_average.png` | Serie temporal con promedios móviles |
| `08_mom_variation.png` | Variación mensual de ingresos (MoM %) |

---

## Principales hallazgos

- Las subcategorías con mayor descuento promedio (Tables, Bookcases) presentan margen negativo.
- El segmento Consumer genera el mayor volumen de ingresos pero Corporate tiene mejor ticket promedio.
- La región West concentra la mayor rentabilidad; Central muestra los márgenes más ajustados.
- La tendencia general de ingresos es positiva con picos recurrentes en el último trimestre de cada año.

---

## Stack tecnológico

`Python` `Pandas` `NumPy` `Scikit-learn` `Matplotlib` `Seaborn` `SQL Server`
