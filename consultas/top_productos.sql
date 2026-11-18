-- Top 20 productos por revenue total
-- Equivalente SQL de la transformación PySpark en notebooks/etl_retail.ipynb (celda 30296489)

WITH datos_limpios AS (
    SELECT
        "StockCode",
        "Description",
        "Quantity",
        ROUND("Quantity" * "Price", 2) AS total_revenue_item
    FROM online_retail
    WHERE "Quantity" > 0
      AND "Price" > 0
      AND "InvoiceDate" IS NOT NULL
)
SELECT
    "StockCode" AS stockcode,
    "Description" AS description,
    ROUND(SUM(total_revenue_item), 2) AS total_revenue,
    SUM("Quantity") AS total_sold
FROM datos_limpios
GROUP BY "StockCode", "Description"
ORDER BY total_revenue DESC
LIMIT 20;
