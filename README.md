# SQL Analytics Case Study

## Project Overview

## Table of Contents

- [Objectives](#objectives)
- [Source Databases](#source-databases)
- [Tools & Technologies](#tools--technologies)
- [Project Structure](#project-structure)
- [Views](#views)
- [Functions](#functions)
- [Stored Procedures](#stored-procedures)
- [SQL Analysis](#sql-analysis)
- [Dataset & GitHub Data](#dataset--github-data)
- [Project Highlights](#project-highlights)

## Objectives

- Analyze sales performance across customers, products, markets, and time periods.
- Evaluate sales forecasts, forecast errors, and forecast accuracy.
- Analyze customer, product, and market-level performance and contribution.
- Calculate gross sales, net invoice sales, and final net sales (revenue) using reusable SQL logic.
- Analyze finance-related metrics such as pricing, discounts, deductions, manufacturing costs, and freight costs.
- Support supply chain analysis using sales, forecast, product, customer, and market data.
- Build reusable SQL logic using views, functions, and stored procedures.
- Create a custom date lookup table with a generated fiscal year column for time-based analysis and query optimization.
- Apply CTEs, window functions, joins, aggregations, and subqueries to solve business problems.
- Apply SQL optimization techniques, including lookup tables and precomputed fiscal-year values, to improve query performance on large datasets.
- Generate structured analytical outputs that can be further used in Business Intelligence tools such as Power BI and Tableau to support data-driven business decisions.

## Source Databases

The project uses two source databases, each serving a different purpose in the business analysis.

### gdb041 – Sales & Supply Chain Analytics

`gdb041` is the primary business analytics database. It contains customer, product, market, date, sales, and forecast data used to analyze sales performance and supply chain-related metrics.

It can be used to:
- Analyze sales performance across customers, products, markets, and time periods.
- Compare actual sales with forecast quantities.
- Measure forecast accuracy and forecast errors.
- Analyze customer, product, and market contribution.
- Perform fiscal year and fiscal quarter analysis.
- Provide lookup data for efficient analytical queries.

**Dimension Tables**

- `dim_customer` – Customer information
- `dim_date` – Custom date lookup table with a generated fiscal year column, used for fiscal analysis and query optimization
- `dim_market` – Market, sub-zone, and region information
- `dim_product` – Product, division, segment, and category information

**Fact & Transactional Tables**

| Table | Description | Original Row Count |
|---|---|---:|
| `fact_sales_monthly` | Monthly sales transactions | 1,425,706 |
| `fact_forecast_monthly` | Monthly sales forecast data | 1,885,941 |
| `fact_actual_estimates` | Actual sales compared with forecast quantities | 1,920,810 |


### gdb056 – Pricing, Discounts & Cost Analytics

`gdb056` is a supporting database containing product-level pricing, discounts, deductions, and cost information across fiscal years. These tables can be combined with the sales data in `gdb041` to perform financial analysis and calculate net sales.

It can be used to:
- Analyze product-level pricing across fiscal years.
- Analyze pre-invoice discounts and post-invoice deductions.
- Calculate gross sales, net invoice sales, and final net sales.
- Analyze manufacturing and freight costs by product and fiscal year.
- Support finance and cost-related business analysis.

**Tables**

- `gross_price` – Product-level gross price by fiscal year
- `manufacturing_cost` – Product-level manufacturing cost by fiscal year
- `freight_cost` – Market-level freight and other cost percentages by fiscal year
- `pre_invoice_deductions` – Customer-level pre-invoice discount percentages by fiscal year
- `post_invoice_deductions` – Customer and product-level discounts and deductions by date

## Tools & Technologies

- **Database:** MySQL
- **Language:** SQL
- **IDE:** MySQL Workbench
- **Version Control:** Git & GitHub
- **Data Analysis:** SQL Queries, CTEs, Window Functions
- **Database Development:** Views, Functions, Stored Procedures
- **Optimization:** Query Performance Optimization

## Project Structure

```text
Business-Data-Analytics-SQL/
│
├── 01_Database/
│   ├── gdb041/
│   │   ├── schema/
│   │   └── sample_data/
│   │
│   └── gdb056/
│       ├── schema/
│       └── sample_data/
│
├── 02_Views/
│
├── 03_Functions/
│
├── 04_Stored_Procedures/
│
├── 05_Analysis_Queries/
│
├── 06_Screenshots/
│
├── .gitignore
└── README.md

```

## Views

The project uses a step-by-step sales calculation pipeline to transform transactional sales data into final net sales (revenue).

| View | Purpose | SQL | Sample Output |
|---|---|---|---|
| `sales_pre_invoice_discount` | Combines sales, customer, product, date, pricing, and pre-invoice discount data to calculate gross sales and pre-invoice discounts. | [SQL](02_Views/generated_view_sales_pre_invoice_discount.sql) | [Output](02_Views/sales_pre_invoice_discount_sample_data.csv) |
| `sales_post_invoice_discount` | Applies post-invoice discounts and deductions to calculate net invoice sales. | [SQL](02_Views/generated_view_sales_post_invoice_discount.sql) | [Output](02_Views/sales_post_invoice_discount_sample_data.csv) |
| `net_sales` | Calculates final net sales (revenue) after applying post-invoice discounts and deductions. | [SQL](02_Views/generated_view_net_sales.sql) | [Output](02_Views/net_sales_sample_data.csv) |

### Sales Calculation Flow

`fact_sales_monthly` → `sales_pre_invoice_discount` → `sales_post_invoice_discount` → `net_sales`

The final `net_sales` output can be further used for business analysis, reporting, and Business Intelligence tools such as Power BI and Tableau.


## Functions

The project includes reusable MySQL functions for fiscal period calculations. These functions provide a standardized way to derive fiscal periods when calculations are required.

### `get_fiscal_year`

Determines the fiscal year from a calendar date based on the project's fiscal-year definition.

**Purpose:**
- Converts a calendar date into the corresponding fiscal year.
- Provides reusable fiscal-year logic for date-based analysis.

**Usage in the project:**
- Used to demonstrate fiscal-year calculation logic.
- The project also uses the precomputed `fiscal_year` column in the custom `dim_date` lookup table for analytical queries and performance optimization, avoiding repeated fiscal-year calculations on large datasets.

**SQL:** [View Function](03_Functions/get_fiscal_year.sql)

---

### `get_fiscal_quarter`

Determines the fiscal quarter from a calendar date based on the project's fiscal-year calendar.

**Purpose:**
- Converts a calendar date into Q1, Q2, Q3, or Q4.
- Provides reusable fiscal-quarter logic for time-based analysis.

**Usage in the project:**
- Used for fiscal-quarter calculations and time-based business analysis.
- Provides a reusable function that can be applied whenever fiscal-quarter information needs to be derived from a date.

**SQL:** [View Function](03_Functions/get_fiscal_quarter.sql)

## Stored Procedures

The project includes a collection of **parameterized MySQL stored procedures** developed for reusable business analysis and reporting.

Instead of writing a new SQL query for every reporting requirement, these procedures allow users to provide specific inputs such as **fiscal year, market, customer codes, or Top-N values** and receive the required analytical result.


The procedures act as a reusable SQL reporting layer over the sales, forecast, customer, product, market, and `net_sales` data.

### How the Stored Procedures Work

```text
Business Question
       ↓
User Provides Required Inputs
(Fiscal Year / Market / Top N / Customer Codes)
       ↓
Stored Procedure
       ↓
SQL Business Logic
       ↓
Aggregations / Calculations / Ranking
       ↓
Analytical Result
       ↓
Business Analysis / Reporting
       ↓
Power BI / Tableau / Other BI Tools
```

## Stored Procedures Summary

| Business Area | Stored Procedure | Input | Analysis Level | SQL |
|---|---|---|---|---|
| Forecast | `get_forecast_accuracy` | Fiscal Year | Customer | [View SQL](04_Stored_Procedures/get_forecast_accuracy.sql) |
| Market | `market_badge` | Fiscal Year, Market | Market | [View SQL](04_Stored_Procedures/get_market_badge.sql) |
| Customer | `monthly_customer_sales` | Customer Codes | Customer / Time | [View SQL](04_Stored_Procedures/get_monthly_customer_sales.sql) |
| Product / Division | `top_n_products_division_qty_sold` | Top N, Fiscal Year | Product / Division | [View SQL](04_Stored_Procedures/get_top_n_products_division_qty_sold.sql) |
| Customer / Market | `top_n_sales_customers` | Top N, Fiscal Year, Market | Customer / Market | [View SQL](04_Stored_Procedures/get_top_n_sales_customers.sql) |
| Market | `top_n_sales_market` | Fiscal Year, Top N | Market | [View SQL](04_Stored_Procedures/get_top_n_sales_market.sql) |
| Product | `top_n_sales_product` | Fiscal Year, Top N | Product | [View SQL](04_Stored_Procedures/get_top_n_sales_product.sql) |

# SQL Analysis

## Croma Sales Analysis – FY2021

## Business Question

What were the gross sales generated by each product for Croma during fiscal year 2021?

## Analysis

The query combines monthly sales, product details, and fiscal-year-based gross prices to calculate product-level gross sales for customer `90002002`.

**Calculation:**

`Sold Quantity × Gross Price = Gross Sales`

## Customer Net Sales Contribution – FY2021

## Business Question

What percentage of total net sales is contributed by each customer during fiscal year 2021?

## Analysis

The query calculates total net sales for each customer and then uses a window function to calculate each customer's percentage contribution to overall net sales.

**Calculation:**

`Customer Net Sales ÷ Total Net Sales × 100 = Customer Share`

## SQL Concepts Used

- CTE
- `SUM()`
- `GROUP BY`
- Window function
- `OVER()`
- Percentage calculation
- `WHERE`

## Results

The output contains **75 customers** with their total net sales and percentage contribution.

Examples:

| Customer | Net Sales (M) | Share |
|---|---:|---:|
| Atliq e Store | 70.14 | 8.52% |
| AltiQ Exclusive | 69.15 | 8.40% |
| Neptune | 20.96 | 2.55% |

The analysis shows how total sales are distributed across the customer base.

## Files

- [SQL Query](customer_share_pct.sql)
- [Query Output](output_customer_share_pct.csv)

## Customer Regional Sales Contribution – FY2021

## Business Question

What percentage of sales does each customer contribute within their region during fiscal year 2021?

## Analysis

The query calculates total net sales for each customer by region and then uses a window function with `PARTITION BY region` to calculate each customer's share of regional sales.

**Calculation:**

`Customer Regional Net Sales ÷ Total Regional Net Sales × 100 = Regional Share`

## SQL Concepts Used

- CTE
- `JOIN`
- `SUM()`
- `GROUP BY`
- Window function
- `PARTITION BY`
- Percentage calculation
- `WHERE`

## Results

The output provides customer-level net sales and percentage contribution within each region for fiscal year 2021.

The analysis helps compare customer contribution across regions and identify customers with a significant share of regional sales.

## Files

- [SQL Query](market_region_share_pct.sql)
- [Query Output](output_market_region_share_pct.csv)

## Top 3 Products by Division – FY2021

## Business Question

Which products have the highest quantity sold within each division during fiscal year 2021?

## Analysis

The query first calculates total quantity sold for each product within each division. It then uses `DENSE_RANK()` with `PARTITION BY division` to rank products and returns the top 3 from each division.

## SQL Concepts Used

- CTEs
- `SUM()`
- `GROUP BY`
- `DENSE_RANK()`
- Window function
- `PARTITION BY`
- Top-N filtering
- `WHERE`

## Results

The output identifies the **top 3 products within each division** based on total quantity sold.

Example:

| Division | Product | Quantity Sold | Rank |
|---|---|---:|---:|
| N & S | AQ Pen Drive DRC | 2,034,569 | 1 |
| N & S | AQ Digit SSD | 1,240,149 | 2 |
| N & S | AQ Clx1 | 1,238,683 | 3 |

The analysis helps compare product performance within individual divisions rather than across the entire product portfolio.

## Files

- [SQL Query](top_3_products_by_division_2021.sql)
- [Query Output](output_top_3_products_by_division_2021.csv)

## Forecast Error Analysis – FY2021

## Business Question

How different were actual sales from forecast quantities during fiscal year 2021?

## Analysis

The query compares actual sold quantities with forecast quantities at the **date, customer, and product** level.

It calculates net error and absolute error, along with their percentage values, to measure the difference between actual and forecast quantities.

**Calculations:**

`Net Error = Forecast Quantity − Sold Quantity`

`Net Error % = Net Error ÷ Forecast Quantity × 100`

`Absolute Error = |Forecast Quantity − Sold Quantity|`

`Absolute Error % = Absolute Error ÷ Forecast Quantity × 100`

## SQL Concepts Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `SUM()`
- `ABS()`
- Calculated metrics
- Percentage calculations
- Multi-column grouping

## Results

The results show actual quantity, forecast quantity, net error, net error percentage, absolute error, and absolute error percentage for each date, customer, and product combination.

This helps identify where forecasts were above or below actual sales and measure the magnitude of forecast deviations.

## Files

- [SQL Query](forecast_accuracy_2021.sql)
- [Query Output](output_forecast_accuracy_2021.csv)

## Forecast Accuracy Comparison – FY2020 vs FY2021

## Business Question

How did customer-level forecast performance compare between fiscal years 2020 and 2021?

## Analysis

This analysis calculates and compares forecast performance for each customer across FY2020 and FY2021.

For each fiscal year, the query calculates:

- Total sold quantity
- Total forecast quantity
- Net error
- Net error percentage
- Absolute error
- Absolute error percentage
- Forecast accuracy

The results are then combined by customer to compare FY2020 and FY2021 forecast accuracy.

## Calculations

**Net Error**

`Forecast Quantity − Sold Quantity`

**Net Error %**

`Net Error ÷ Forecast Quantity × 100`

**Absolute Error**

`|Forecast Quantity − Sold Quantity|`

**Absolute Error %**

`Absolute Error ÷ Forecast Quantity × 100`

**Forecast Accuracy**

`100 − Absolute Error %`

The accuracy value is limited to a minimum of 0.

## SQL Approach

1. Create a temporary table containing FY2021 forecast error metrics.
2. Calculate FY2021 forecast accuracy.
3. Create a temporary table containing FY2020 forecast error metrics.
4. Calculate FY2020 forecast accuracy.
5. Join the two yearly results by customer.
6. Compare forecast accuracy between the two fiscal years.
7. Return customers whose FY2020 accuracy was higher than FY2021.

## SQL Concepts Used

- Temporary tables
- CTE
- `SUM()`
- `ABS()`
- `IF()`
- `JOIN`
- `GROUP BY`
- Percentage calculations
- Multiple calculated metrics
- Year-over-year comparison
- Filtering

## Results

The final output contains **60 customers** whose forecast accuracy was higher in FY2020 than in FY2021.

Example:

| Customer | FY2020 Accuracy | FY2021 Accuracy |
|---|---:|---:|
| Euronics Austria | 56.47% | 41.45% |
| Nova Austria | 56.27% | 42.69% |
| Integration Stores Austria | 55.96% | 43.54% |

The analysis provides a detailed customer-level comparison of forecast performance across two fiscal years.

## Files

- [SQL Query](forecast_accuracy_comparison_2020_2021.sql)
- [Query Output](output_forecast_accuracy_comparison_2020_2021.csv)

## Sales vs Forecast Data Reconciliation

## Business Question

How can sales and forecast records be combined while retaining records that exist in either dataset?

## Analysis

This analysis combines monthly sales and forecast data and retains both matching and unmatched records.

Because MySQL does not provide a direct `FULL OUTER JOIN`, the query uses two `LEFT JOIN` operations with `UNION ALL`:

- First, retrieves all sales records and matching forecast records.
- Second, retrieves forecast records that do not have a matching sales record.

## SQL Concepts Used

- `LEFT JOIN`
- `UNION ALL`
- `WHERE`
- `NULL` filtering
- Join conditions
- Dataset reconciliation

## Results

- Sales records with matching forecasts
- Sales records without matching forecasts
- Forecast records without matching sales

This provides a combined view of sales and forecast data without losing unmatched records from either dataset.

## Files

- [SQL Query](sales_forecast_full_outer_join.sql)
- [Query Output](output_sales_forecast_full_outer_join.csv)

## Sales Analysis Using Lookup Tables

## Business Question

How can lookup tables be used to retrieve fiscal-year-based pricing and discount information for sales analysis?

## Analysis

The query uses the custom `dim_date` lookup table to obtain the fiscal year for each sales transaction.

That fiscal year is then used to join gross price and pre-invoice deduction data. The query calculates total gross sales and retrieves the applicable pre-invoice discount for customer `90002002` in FY2021.

**Calculation:**

`Sold Quantity × Gross Price = Total Gross Sales`

## SQL Concepts Used

- Multiple `JOIN` operations
- Lookup tables
- `USING` and `ON`
- Fiscal-year mapping
- Calculated columns
- `ROUND()`
- `WHERE`
- Cross-database table joins

## Results

The output contains **3,006 records** with:

- Date
- Product
- Variant
- Sold quantity
- Gross price
- Total gross sales
- Pre-invoice discount percentage

The analysis demonstrates how a date lookup table can provide fiscal-year information for joining sales with fiscal-year-based pricing and discount data.

## Files

- [SQL Query](01_performance_optimization_using_look_up_tables.sql)
- [Query Output](output_performance_optimization_using_look_up_tables.csv)

## Sales Analysis Using Precomputed Fiscal Year

## Business Question

How can an existing fiscal-year column simplify fiscal-year-based joins and avoid recalculating fiscal year during the query?

## Analysis

This query uses the existing `fiscal_year` column in `fact_sales_monthly` directly when joining gross price and pre-invoice deduction data.

It calculates total gross sales and retrieves the applicable pre-invoice discount for customer `90002002` in FY2021 without deriving fiscal year from the transaction date.

**Calculation:**

`Sold Quantity × Gross Price = Total Gross Sales`

## SQL Concepts Used

- Multiple `JOIN` operations
- `USING` and `ON`
- Precomputed columns
- Fiscal-year filtering
- Calculated columns
- `ROUND()`
- Cross-database joins
- Query optimization

## Results

The output contains **3,006 records** with:

- Date
- Product
- Variant
- Sold quantity
- Gross price
- Total gross sales
- Pre-invoice discount percentage

Using the existing fiscal-year value avoids repeating fiscal-year calculations during the joins and provides a simpler approach for large-data analytical queries.

## Files

- [SQL Query](02_performance_optimization_fiscal_year.sql)
- [Query Output](output_performance_optimization_fiscal_year.csv)


## SQL Concepts Used

- `SELECT` and `WHERE`
- `JOIN` / `USING` / `ON`
- User-defined function
- Calculated columns
- Fiscal-year filtering

## Results

The output provides **3,006 sales records** containing date, product, variant, sold quantity, gross price, and total gross sales.

The analysis can be used to compare product-level sales performance for the customer.

## Files

- [SQL Query](croma_2021_sales.sql)
- [Query Output](output_croma_sales.csv)



## Dataset & GitHub Data

The project uses data from two MySQL databases: `gdb041` and `gdb056`.

The repository includes the database schemas and sample datasets required to understand and reproduce the SQL analysis.

- SQL files are provided for database schemas and table structures.
- CSV files are provided as sample datasets where applicable.
- Large database tables are represented through their schema and sample data rather than complete database dumps.
- The database files are organized separately under the `01_Database` folder.

### Database Files

- [`gdb041`](01_Database/gdb041/) – Sales and supply chain analytics data
- [`gdb056`](01_Database/gdb056/) – Pricing, discounts, deductions, and cost analytics data

These datasets support the SQL views, functions, stored procedures, and analysis queries included in the project.

## Project Highlights

- Built a **MySQL-based business analytics solution** using `gdb041` and `gdb056` to support sales, forecasting, pricing, discount, and cost analysis.
- Enables **Sales teams** to analyze performance across customers, products, markets, regions, and fiscal periods.
- Helps **Supply Chain teams** compare actual sales with forecasts, identify forecast errors, and evaluate forecast accuracy.
- Helps **Business and Sales Managers** understand customer contribution, regional sales share, and top-performing products.
- Supports **Finance teams** in analyzing gross sales, discounts, deductions, net invoice sales, final net sales, and related costs.
- Provides reusable **SQL views, functions, and stored procedures** so team members can retrieve standardized business metrics without rewriting complex queries.
- Uses advanced SQL techniques such as **CTEs, window functions, joins, aggregations, temporary tables, and subqueries** to solve business problems.
- Includes a structured **sales calculation pipeline** from gross sales through discounts and deductions to final net sales.
- Applies **query optimization** using lookup tables and precomputed fiscal-year values to support efficient analysis of large datasets.
- Provides documented SQL analyses and reusable outputs that can serve as a **data source for BI tools such as Power BI and Tableau**, enabling teams to build dashboards and reports for decision-making.
