-- Indicadores clave de negocio para el análisis comercial y de rentabilidad.


-- Ingresos, beneficio y margen por mes
SELECT
    FORMAT(order_date, 'yyyy-MM')      AS mes,
    COUNT(DISTINCT order_id)           AS pedidos,
    SUM(quantity)                      AS unidades,
    ROUND(SUM(sales), 2)               AS ingresos,
    ROUND(SUM(profit), 2)              AS beneficio,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY mes;


-- Rendimiento por categoría y subcategoría
SELECT
    p.category,
    p.sub_category,
    COUNT(DISTINCT s.order_id)         AS pedidos,
    SUM(s.quantity)                    AS unidades,
    ROUND(SUM(s.sales), 2)             AS ingresos,
    ROUND(SUM(s.profit), 2)            AS beneficio,
    ROUND(AVG(s.discount) * 100, 2)    AS descuento_promedio_pct,
    ROUND(SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales s
JOIN dbo.products p ON s.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY ingresos DESC;


-- Top 10 productos por ingresos
SELECT TOP 10
    p.product_name,
    p.category,
    p.sub_category,
    SUM(s.quantity)                    AS unidades,
    ROUND(SUM(s.sales), 2)             AS ingresos,
    ROUND(SUM(s.profit), 2)            AS beneficio,
    ROUND(SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales s
JOIN dbo.products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.sub_category
ORDER BY ingresos DESC;


-- 10 productos con peor rentabilidad (candidatos a revisión)
SELECT TOP 10
    p.product_name,
    p.category,
    ROUND(SUM(s.sales), 2)             AS ingresos,
    ROUND(SUM(s.profit), 2)            AS beneficio,
    ROUND(AVG(s.discount) * 100, 2)    AS descuento_promedio_pct
FROM dbo.sales s
JOIN dbo.products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY beneficio ASC;


-- Comparativa por segmento de cliente
SELECT
    c.segment,
    COUNT(DISTINCT s.order_id)         AS pedidos,
    COUNT(DISTINCT s.customer_id)      AS clientes,
    ROUND(SUM(s.sales), 2)             AS ingresos,
    ROUND(SUM(s.profit), 2)            AS beneficio,
    ROUND(SUM(s.sales) / NULLIF(COUNT(DISTINCT s.order_id), 0), 2) AS ticket_promedio,
    ROUND(SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales s
JOIN dbo.customers c ON s.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY ingresos DESC;


-- Ingresos por región y estado
SELECT
    c.region,
    c.state,
    COUNT(DISTINCT s.order_id)         AS pedidos,
    ROUND(SUM(s.sales), 2)             AS ingresos,
    ROUND(SUM(s.profit), 2)            AS beneficio,
    ROUND(SUM(s.profit) / NULLIF(SUM(s.sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales s
JOIN dbo.customers c ON s.customer_id = c.customer_id
GROUP BY c.region, c.state
ORDER BY c.region, ingresos DESC;


-- Impacto del descuento en el margen, agrupado por bandas
SELECT
    CASE
        WHEN discount = 0       THEN '0% — sin descuento'
        WHEN discount <= 0.10   THEN '1% – 10%'
        WHEN discount <= 0.20   THEN '11% – 20%'
        WHEN discount <= 0.30   THEN '21% – 30%'
        WHEN discount <= 0.50   THEN '31% – 50%'
        ELSE                         '> 50%'
    END                              AS banda_descuento,
    COUNT(*)                         AS transacciones,
    ROUND(SUM(sales), 2)             AS ingresos,
    ROUND(SUM(profit), 2)            AS beneficio,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS margen_pct
FROM dbo.sales
GROUP BY
    CASE
        WHEN discount = 0       THEN '0% — sin descuento'
        WHEN discount <= 0.10   THEN '1% – 10%'
        WHEN discount <= 0.20   THEN '11% – 20%'
        WHEN discount <= 0.30   THEN '21% – 30%'
        WHEN discount <= 0.50   THEN '31% – 50%'
        ELSE                         '> 50%'
    END
ORDER BY margen_pct DESC;


-- Crecimiento año sobre año
WITH yearly AS (
    SELECT
        YEAR(order_date)      AS anio,
        ROUND(SUM(sales), 2)  AS ingresos,
        ROUND(SUM(profit), 2) AS beneficio
    FROM dbo.sales
    GROUP BY YEAR(order_date)
)
SELECT
    anio,
    ingresos,
    beneficio,
    LAG(ingresos) OVER (ORDER BY anio) AS ingresos_anio_anterior,
    ROUND(
        (ingresos - LAG(ingresos) OVER (ORDER BY anio))
        / NULLIF(LAG(ingresos) OVER (ORDER BY anio), 0) * 100
    , 2) AS crecimiento_yoy_pct
FROM yearly
ORDER BY anio;
