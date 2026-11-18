-- Ventas agregadas por país (revenue total, nro facturas, ticket promedio, items vendidos)
-- Equivalente SQL de la transformación PySpark en notebooks/etl_retail.ipynb (celda 30296489)
-- Nota: df2 ya viene filtrado (Quantity > 0, Price > 0, fecha válida) y con TotalRevenue = Quantity * Price

WITH datos_limpios AS (
    SELECT
        "Invoice",
        "Country",
        "Quantity",
        ROUND("Quantity" * "Price", 2) AS total_revenue_item
    FROM online_retail
    WHERE "Quantity" > 0
      AND "Price" > 0
      AND "InvoiceDate" IS NOT NULL
)
SELECT
    "Country" AS country,
    ROUND(SUM(total_revenue_item), 2) AS total_revenue,
    COUNT(DISTINCT "Invoice") AS num_invoices,
    ROUND(AVG(total_revenue_item), 2) AS avg_revenue_per_item,
    SUM("Quantity") AS total_items_sold
FROM datos_limpios
GROUP BY "Country"
ORDER BY total_revenue DESC;
