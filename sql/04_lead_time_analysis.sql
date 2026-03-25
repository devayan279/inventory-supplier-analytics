SELECT 
    supplier_name,
    ROUND(AVG(lead_time), 2) AS avg_lead_time,
    ROUND(MIN(lead_time), 2) AS min_lead_time,
    ROUND(MAX(lead_time), 2) AS max_lead_time,
    ROUND(MAX(lead_time) - MIN(lead_time), 2) AS lead_time_variability,
    COUNT(*) AS total_orders,

    CASE 
        WHEN (MAX(lead_time) - MIN(lead_time)) > 20 THEN 'High Risk'
        WHEN (MAX(lead_time) - MIN(lead_time)) > 10 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS risk_category

FROM supply_chain_data

GROUP BY supplier_name

ORDER BY lead_time_variability DESC;