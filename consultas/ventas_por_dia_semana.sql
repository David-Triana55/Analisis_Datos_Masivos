-- Ventas agregadas por día de la semana (1=domingo ... 7=sábado, convención Spark dayofweek)
-- Equivalente SQL de la transformación PySpark en notebooks/etl_retail.ipynb (celda 30296489)

WITH datos_limpios AS (
    SELECT
        "Invoice",
        "Quantity",
        ROUND("Quantity" * "Price", 2) AS total_revenue_item,
        EXTRACT(ISODOW FROM "InvoiceDate") AS day_of_week
    FROM online_retail
    WHERE "Quantity" > 0
      AND "Price" > 0
      AND "InvoiceDate" IS NOT NULL
)
SELECT
    day_of_week,
    ROUND(SUM(total_revenue_item), 2) AS total_revenue,
    COUNT(DISTINCT "Invoice") AS num_invoices
FROM datos_limpios
GROUP BY day_of_week
ORDER BY day_of_week;
