WITH product_sales AS (
    SELECT 
        sku,
        product_type,
        SUM(revenue_generated) AS total_revenue,
        AVG(order_quantities) AS avg_demand,
        COUNT(*) AS demand_count
    FROM supply_chain_data
    GROUP BY sku, product_type
),

revenue_rank AS (
    SELECT *,
        NTILE(3) OVER (ORDER BY total_revenue DESC) AS revenue_category
    FROM product_sales
),

demand_variability AS (
    SELECT 
        sku,
        product_type,
        AVG(order_quantities) AS avg_demand,
        CASE 
            WHEN AVG(order_quantities) > 60 THEN 'X'
            WHEN AVG(order_quantities) > 30 THEN 'Y'
            ELSE 'Z'
        END AS demand_category
    FROM supply_chain_data
    GROUP BY sku, product_type
)

SELECT 
    r.sku,
    r.product_type,
    r.total_revenue,
    d.avg_demand,

    CASE 
        WHEN r.revenue_category = 1 THEN 'A'
        WHEN r.revenue_category = 2 THEN 'B'
        ELSE 'C'
    END AS abc_category,

    d.demand_category,

    (CASE 
        WHEN r.revenue_category = 1 THEN 'A'
        WHEN r.revenue_category = 2 THEN 'B'
        ELSE 'C'
    END || d.demand_category) AS abc_xyz_class

FROM revenue_rank r
JOIN demand_variability d
ON r.sku = d.sku AND r.product_type = d.product_type

ORDER BY r.total_revenue DESC;