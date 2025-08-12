SELECT 
    EXTRACT(YEAR FROM bo.order_date) AS order_year,
    EXTRACT(MONTH FROM bo.order_date) AS order_month,
    SUM(unit_price) AS revenue,
    COUNT(bo.order_id) AS volume
FROM blinkit_products bp
JOIN blinkit_order_items oi 
    ON bp.product_id = oi.product_id
JOIN blinkit_orders bo 
    ON bo.order_id = oi.order_id
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

WITH monthly_data AS (
    SELECT 
        EXTRACT(YEAR FROM bo.order_date) AS order_year,
        EXTRACT(MONTH FROM bo.order_date) AS order_month,
        SUM(unit_price) AS revenue,
        COUNT(DISTINCT bo.order_id) AS volume
    FROM blinkit_products bp
    JOIN blinkit_order_items oi 
        ON bp.product_id = oi.product_id
    JOIN blinkit_orders bo 
        ON bo.order_id = oi.order_id
    GROUP BY order_year, order_month
)
SELECT 
    order_year,
    order_month,
    revenue,
    volume,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY order_year, order_month))
        / LAG(revenue) OVER (ORDER BY order_year, order_month) * 100, 2
    ) AS revenue_growth,
    ROUND(
        (volume - LAG(volume) OVER (ORDER BY order_year, order_month))
        / LAG(volume) OVER (ORDER BY order_year, order_month) * 100, 2
    ) AS growth_volume
FROM monthly_data
ORDER BY order_year, order_month;


