-- Serie temporal de ventas por año/mes
-- Equivalente SQL de la transformación PySpark en notebooks/etl_retail.ipynb (celda 30296489)

WITH datos_limpios AS (
    SELECT
        "Invoice",
        "Quantity",
        ROUND("Quantity" * "Price", 2) AS total_revenue_item,
        EXTRACT(YEAR FROM "InvoiceDate") AS year,
        EXTRACT(MONTH FROM "InvoiceDate") AS month
    FROM online_retail
    WHERE "Quantity" > 0
      AND "Price" > 0
      AND "InvoiceDate" IS NOT NULL
)
SELECT
    year,
    month,
    ROUND(SUM(total_revenue_item), 2) AS total_revenue,
    COUNT(DISTINCT "Invoice") AS num_invoices,
    SUM("Quantity") AS total_items
FROM datos_limpios
GROUP BY year, month
ORDER BY year, month;
