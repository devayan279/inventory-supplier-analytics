DROP TABLE IF EXISTS supply_chain_data;

CREATE TABLE supply_chain_data (
    product_type TEXT,
    sku TEXT,
    price REAL,
    availability INTEGER,
    number_of_products_sold INTEGER,
    revenue_generated REAL,
    customer_demographics TEXT,
    stock_levels INTEGER,
    lead_time INTEGER,
    order_quantities INTEGER,
    shipping_times INTEGER,
    shipping_carriers TEXT,
    shipping_costs REAL,
    supplier_name TEXT,
    location TEXT,
    lead_time_variability REAL,
    manufacturing_costs REAL,
    inspection_results TEXT,
    defect_rates REAL,
    transportation_modes TEXT,
    routes TEXT,
    costs REAL
);

SELECT COUNT(*) FROM supply_chain_data;

SELECT * FROM supply_chain_data LIMIT 10;