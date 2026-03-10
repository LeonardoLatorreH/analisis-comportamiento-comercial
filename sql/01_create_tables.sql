-- Tablas para cargar los datos del dataset Superstore en SQL Server.
-- Ejecutar este script primero antes de cualquier carga o consulta.

IF OBJECT_ID('dbo.sales', 'U')      IS NOT NULL DROP TABLE dbo.sales;
IF OBJECT_ID('dbo.products', 'U')   IS NOT NULL DROP TABLE dbo.products;
IF OBJECT_ID('dbo.customers', 'U')  IS NOT NULL DROP TABLE dbo.customers;


CREATE TABLE dbo.customers (
    customer_id   VARCHAR(20)  NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    segment       VARCHAR(50)  NOT NULL,
    country       VARCHAR(50)  NOT NULL,
    city          VARCHAR(100) NOT NULL,
    state         VARCHAR(100) NOT NULL,
    region        VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_customers PRIMARY KEY (customer_id)
);


CREATE TABLE dbo.products (
    product_id   VARCHAR(50)  NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category     VARCHAR(50)  NOT NULL,
    sub_category VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_products PRIMARY KEY (product_id)
);


-- Una fila por línea de pedido, con FK hacia clientes y productos
CREATE TABLE dbo.sales (
    row_id      INT           NOT NULL,
    order_id    VARCHAR(20)   NOT NULL,
    order_date  DATE          NOT NULL,
    ship_date   DATE          NOT NULL,
    ship_mode   VARCHAR(50)   NOT NULL,
    customer_id VARCHAR(20)   NOT NULL,
    product_id  VARCHAR(50)   NOT NULL,
    sales       DECIMAL(10,2) NOT NULL,
    quantity    INT           NOT NULL,
    discount    DECIMAL(4,2)  NOT NULL,
    profit      DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_sales      PRIMARY KEY (row_id),
    CONSTRAINT FK_sales_cust FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_sales_prod FOREIGN KEY (product_id)  REFERENCES dbo.products(product_id)
);
