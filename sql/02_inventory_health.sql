SELECT 
    product_type,
    sku,
    SUM(stock_levels) AS total_stock,
    SUM(order_quantities) AS total_orders,
    AVG(lead_time) AS avg_lead_time,
    AVG(defect_rates) AS avg_defect_rate,
    ROUND(SUM(stock_levels) * 1.0 / NULLIF(SUM(order_quantities), 0), 2) AS stock_to_demand_ratio,
    CASE 
        WHEN SUM(stock_levels) * 1.0 / NULLIF(SUM(order_quantities), 0) > 2 THEN 'Overstocked'
        WHEN SUM(stock_levels) * 1.0 / NULLIF(SUM(order_quantities), 0) < 0.5 THEN 'Stockout Risk'
        ELSE 'Healthy'
    END AS inventory_status
FROM supply_chain_data
GROUP BY product_type, sku
ORDER BY stock_to_demand_ratio DESC;