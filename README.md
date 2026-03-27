# inventory-supplier-analytics

A end-to-end inventory and supplier analytics project built on a real-world supply chain dataset. The project covers the full workflow — from raw data ingestion and cleaning, through SQL-based analytics, to Power BI dashboards — with outputs structured for enterprise planning use cases.

---

## What This Project Does

Raw supply chain data (100 SKUs across 3 product categories, 5 suppliers) is ingested, cleaned, and transformed into a set of analytics outputs covering:

- **Inventory health** — stock-to-demand ratios, overstock flags, and stockout risk classification per SKU
- **Supplier scorecards** — lead time, defect rate, shipping cost, and revenue benchmarked across suppliers
- **Lead time risk analysis** — variability ranges and risk tiers (Low / Moderate / High) per supplier
- **ABC-XYZ classification** — revenue-based segmentation (A/B/C) crossed with demand variability (X/Y/Z) for each SKU
- **Power BI dashboard** — interactive visuals consuming the cleaned output CSVs

---

## Repository Structure

```
inventory-supplier-analytics/
│
├── data/
│   └── supply_chain_data.csv          
│
├── notebook/
│   ├── 01_etl_and_db_load.ipynb       
│   └── 02_inventory_analysis.ipynb    
│
├── outputs/
│   ├── inventory_master.csv           
│   ├── inventory_health.csv          
│   ├── supplier_scorecard.csv         
│   ├── lead_time_analysis.csv       
│   ├── abc_xyz_classification.csv     
│   └── abc_summary.csv              
├── sql/
│   ├── 01_schema_and_load.sql        
│   ├── 02_inventory_health.sql       
│   ├── 03_supplier_scorecard.sql      
│   ├── 04_lead_time_analysis.sql     
│   └── 05_abc_xyz_classification.sql  
│
├── powerbi/
│   └── Power BI devayan.pbix          
│
├── .gitignore
├── LICENSE
└── README.md
```

---

**## Dataset

**Source:** Synthetic supply chain dataset  
**Scope:** 100 SKUs across 3 product categories (skincare, haircare, cosmetics) and 5 suppliers  
**Key fields:** SKU, product type, stock levels, order quantities, lead time, defect rates, shipping costs, revenue generated, supplier name, routes, transportation modes**

---

## Notebooks

### `01_etl_and_db_load.ipynb`
Loads the raw CSV, runs validation checks (nulls, dtypes, duplicates), cleans column names, and ingests the data into a local SQLite database. This database is the foundation for all SQL queries downstream.

### `02_inventory_analysis.ipynb`
Builds the core analytics outputs:
- Computes stock-to-demand ratios and flags SKUs as Overstocked, Healthy, or Stockout Risk
- Runs ABC classification using revenue percentiles and XYZ classification using average order quantities
- Aggregates supplier performance metrics (lead time, defect rate, shipping cost, revenue)
- Exports all outputs as CSVs to the `outputs/` folder for Power BI consumption

---

## SQL Queries

All queries run against the SQLite database loaded in Notebook 01. Each file is self-contained.

| File | Purpose |
|------|---------|
| `01_schema_and_load.sql` | Creates the `supply_chain_data` table and verifies the load |
| `02_inventory_health.sql` | Stock-to-demand ratio with Overstocked / Healthy / Stockout Risk flags |
| `03_supplier_scorecard.sql` | Supplier-level aggregation with Top / Average / Underperforming tiers |
| `04_lead_time_analysis.sql` | Lead time range and variability with Low / Moderate / High Risk tiers |
| `05_abc_xyz_classification.sql` | Revenue-based ABC + demand-based XYZ, joined into a single ABC-XYZ label |

---

## Key Findings

**Inventory health (100 SKUs):**
- 23 SKUs are overstocked (stock-to-demand ratio > 2), concentrated in haircare and cosmetics
- 30 SKUs face stockout risk (ratio < 0.5), with skincare most affected
- Remaining 47 SKUs fall within the healthy range

**Supplier performance (5 suppliers):**
- Supplier 1 is the only Top Supplier — avg defect rate of 1.8%, avg lead time of 14.78 days, highest revenue at ₹1,57,529
- Suppliers 2–5 are Average Suppliers; none qualify as Underperforming under the current thresholds
- Lead time variability is High Risk for most suppliers, indicating inconsistent fulfillment cycles

**ABC-XYZ classification:**
- Class A (top revenue) SKUs in skincare generate ₹1,83,295 but have the highest stockout percentage (27%)
- Class C SKUs in cosmetics show 0% stockout — likely overstocked relative to demand
- XYZ demand patterns skew heavily toward Z (low average order quantity), suggesting fragmented or irregular demand across the portfolio

---

## Power BI Dashboard

The `.pbix` file in `powerbi/` connects to the CSVs in `outputs/`. Open in Power BI Desktop — no additional configuration needed if the folder structure is preserved.

Dashboard pages cover:
- Inventory status overview (overstocked vs. healthy vs. stockout risk)
- Supplier scorecard comparison
- ABC-XYZ classification matrix
- Lead time risk by supplier

---

## Tech Stack

- **Python** — pandas, NumPy (data cleaning, classification logic, CSV exports)
- **SQL** — SQLite via Python's `sqlite3` module (analytics layer)
- **Power BI** — dashboard and reporting layer
- **Jupyter Notebook** — development and documentation environment
- **GitHub** — version control

---

## How to Run

1. Clone the repository
   ```bash
   git clone https://github.com/devayan279/inventory-supplier-analytics.git
   cd inventory-supplier-analytics
   ```

2. Install dependencies
   ```bash
   pip install pandas numpy jupyter
   ```

3. Run the notebooks in order
   ```
   notebook/01_etl_and_db_load.ipynb
   notebook/02_inventory_analysis.ipynb
   ```

4. The `outputs/` CSVs will be refreshed. Open `powerbi/Power BI devayan.pbix` in Power BI Desktop to view the dashboard.

---

## License

MIT
