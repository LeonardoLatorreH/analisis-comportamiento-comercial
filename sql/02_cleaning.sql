-- Validaciones de calidad antes de pasar al análisis.
-- Revisar los resultados de cada sección y corregir lo que corresponda.


-- Nulos en columnas críticas de ventas
SELECT
    SUM(CASE WHEN order_date  IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN product_id  IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN sales        IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN profit       IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM dbo.sales;


-- Duplicados por tabla
SELECT row_id, COUNT(*) AS veces
FROM dbo.sales
GROUP BY row_id
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*) AS veces
FROM dbo.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS veces
FROM dbo.products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- Fechas inconsistentes: ship_date antes de order_date
SELECT order_id, order_date, ship_date
FROM dbo.sales
WHERE ship_date < order_date;


-- Ventas o cantidades en cero o negativas
SELECT row_id, order_id, sales, quantity, profit
FROM dbo.sales
WHERE sales <= 0 OR quantity <= 0;


-- Descuentos fuera del rango 0.0 – 1.0
SELECT row_id, order_id, discount
FROM dbo.sales
WHERE discount < 0 OR discount > 1;


-- Limpiar espacios y normalizar texto en dimensiones
UPDATE dbo.customers
SET
    segment       = TRIM(segment),
    region        = TRIM(region),
    customer_name = LTRIM(RTRIM(customer_name));

UPDATE dbo.products
SET
    category     = TRIM(category),
    sub_category = TRIM(sub_category),
    product_name = LTRIM(RTRIM(product_name));


-- Registros huérfanos: ventas sin cliente o producto asociado
SELECT s.row_id, s.customer_id
FROM dbo.sales s
LEFT JOIN dbo.customers c ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT s.row_id, s.product_id
FROM dbo.sales s
LEFT JOIN dbo.products p ON s.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Resumen final para verificar que la carga fue correcta
SELECT
    COUNT(*)             AS total_filas,
    MIN(order_date)      AS primera_fecha,
    MAX(order_date)      AS ultima_fecha,
    ROUND(SUM(sales), 2)  AS ingresos_totales,
    ROUND(SUM(profit), 2) AS beneficio_total
FROM dbo.sales;
