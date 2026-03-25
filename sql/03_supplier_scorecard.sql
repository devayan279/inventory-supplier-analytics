SELECT 
    supplier_name,
    COUNT(DISTINCT sku) AS total_skus,
    ROUND(AVG(lead_time), 2) AS avg_lead_time,
    ROUND(AVG(defect_rates), 2) AS avg_defect_rate,
    ROUND(AVG(shipping_costs), 2) AS avg_shipping_cost,
    ROUND(SUM(revenue_generated), 2) AS total_revenue,

    CASE 
        WHEN AVG(defect_rates) < 2 AND AVG(lead_time) < 15 THEN 'Top Supplier'
        WHEN AVG(defect_rates) < 5 AND AVG(lead_time) < 25 THEN 'Average Supplier'
        ELSE 'Underperforming'
    END AS supplier_performance

FROM supply_chain_data

GROUP BY supplier_name

ORDER BY total_revenue DESC;