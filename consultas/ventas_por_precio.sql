-- Ventas agrupadas por rango de precio (Low/Medium/High/Premium)
-- Equivalente SQL de la transformación PySpark en notebooks/etl_retail.ipynb (celdas 6885f91e y 30296489)

WITH datos_limpios AS (
    SELECT
        "Quantity",
        "Price",
        ROUND("Quantity" * "Price", 2) AS total_revenue_item,
        CASE
            WHEN "Price" < 2  THEN 'Low'
            WHEN "Price" < 10 THEN 'Medium'
            WHEN "Price" < 50 THEN 'High'
            ELSE 'Premium'
        END AS price_range
    FROM online_retail
    WHERE "Quantity" > 0
      AND "Price" > 0
      AND "InvoiceDate" IS NOT NULL
)
SELECT
    price_range,
    COUNT(*) AS num_transactions,
    ROUND(SUM(total_revenue_item), 2) AS total_revenue,
    ROUND(AVG("Price"), 2) AS avg_price
FROM datos_limpios
GROUP BY price_range
ORDER BY total_revenue DESC;
