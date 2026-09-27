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
- [Performance Optimization](#performance-optimization)
- [SQL Concepts Demonstrated](#sql-concepts-demonstrated)
- [Business Questions](#business-questions)
- [Project Highlights](#project-highlights)
- [Dataset & GitHub Data](#dataset--github-data)

## Objectives

- Analyze sales performance across customers, products, markets, and time periods.
- Evaluate sales forecasts and forecast accuracy.
- Analyze customer and product-level performance.
- Calculate gross sales, net invoice sales, and net sales.
- Analyze finance-related metrics such as pricing, discounts, deductions, and costs.
- Support supply chain analysis using product, market, and sales data.
- Build reusable SQL logic using views, functions, and stored procedures.
- Apply SQL optimization techniques to improve query performance.

## Source Databases

The project uses two source databases containing dimension, fact, and transactional data.

### gdb041

The main analytics database containing:

**Dimension Tables**
- `dim_customer` – Customer information
- `dim_date` – Calendar and fiscal year information
- `dim_market` – Market, sub-zone, and region information
- `dim_product` – Product, division, segment, and category information

**Fact & Transactional Tables**
- `fact_sales_monthly` – Monthly sales transactions
- `fact_forecast_monthly` – Monthly sales forecast data
- `fact_actual_estimates` – Actual sales compared with forecast quantities

### gdb056

The supporting database containing pricing, cost, and deduction data used for financial analysis:

- `gross_price` – Product-level gross pricing
- `manufacturing_cost` – Product manufacturing costs
- `freight_cost` – Freight and other cost percentages
- `pre_invoice_deductions` – Pre-invoice discount information
- `post_invoice_deductions` – Post-invoice discounts and deductions

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

## Views

The project includes SQL views that build the sales calculation flow step by step:

- `sales_pre_invoice_discount` – Combines sales, customer, product, date, pricing, and pre-invoice discount data to calculate gross sales and pre-invoice discounts.
- `sales_post_invoice_discount` – Extends the pre-invoice view by applying post-invoice deductions and calculating net invoice sales.
- `net_sales` – Calculates final net sales after post-invoice discounts.

## Functions

The project includes reusable MySQL functions for fiscal period analysis:

- `get_fiscal_year` – Determines the fiscal year from a calendar date.
- `get_fiscal_quarter` – Determines the fiscal quarter based on the fiscal year calendar.

## Stored Procedures

The project includes reusable stored procedures for business analysis and reporting:

- `get_forecast_accuracy` – Calculates forecast accuracy by customer for a selected fiscal year.
- `market_badge` – Assigns a market badge based on total sold quantity.
- `monthly_customer_sales` – Calculates monthly gross sales for selected customers.
- `top_n_products_division_qty_sold` – Returns the top N products by quantity sold within each division.
- `top_n_sales_customers` – Returns the top N customers by net sales for a selected fiscal year and market.
- `top_n_sales_market` – Returns the top N markets by net sales for a selected fiscal year.
- `top_n_sales_product` – Returns the top N products by net sales for a selected fiscal year.

## SQL Analysis

The project includes SQL analysis covering:

- Customer and product sales performance
- Gross sales and net sales analysis
- Sales forecast accuracy
- Forecast error analysis
- Top products by division
- Top customers by net sales
- Top markets by net sales
- Customer contribution to regional sales
- Customer percentage share of net sales
- Sales and forecast comparison
- Fiscal year-based analysis

## Performance Optimization

The project also includes query optimization techniques to improve SQL performance.

Examples include:

- Using lookup tables to retrieve required attributes instead of repeatedly applying functions.
- Using existing fiscal year columns where available instead of calculating fiscal years repeatedly.
- Reducing unnecessary calculations during large-data queries.
- Comparing query approaches based on execution performance.

## SQL Concepts Demonstrated

- SELECT, WHERE, GROUP BY, HAVING, ORDER BY
- INNER JOIN and LEFT JOIN
- UNION and UNION ALL
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- CASE Statements
- Subqueries
- MySQL Views
- User-Defined Functions
- Stored Procedures
- Input and Output Parameters
- Temporary and derived tables
- Fiscal year and fiscal quarter calculations
- Query optimization

## Business Questions

The analysis addresses questions such as:

- Which customers generate the highest net sales?
- Which products contribute the most to sales?
- Which markets generate the highest net sales?
- How much does each customer contribute to regional net sales?
- How accurate are sales forecasts?
- Which products have the highest forecast error?
- Which products perform best within each division?
- How do actual sales compare with forecast quantities?
- How can sales queries be optimized when working with large datasets?

## Dataset & GitHub Data

The SQL analysis was performed using the original datasets, which contain a large volume of business data.

To keep this repository lightweight and easy to use, the GitHub repository contains smaller sample datasets with a maximum of 5,000 rows per table.

The original full datasets are not included in the repository due to their size.

The sample data is provided to demonstrate the database structure and allow the SQL scripts to be explored and tested.

## Project Highlights

- Built and analyzed relational business data using MySQL.
- Worked with dimension, fact, and transactional data.
- Created reusable SQL views for sales and financial calculations.
- Developed MySQL functions for fiscal year and quarter analysis.
- Built parameterized stored procedures for business reporting.
- Used CTEs, window functions, joins, aggregations, and subqueries for analysis.
- Performed sales, finance, and supply chain analytics.
- Applied query optimization techniques for large datasets.

This project focuses on analyzing business data using MySQL and SQL.

The analysis covers key areas including:

- Sales Analytics
- Finance Analytics
- Supply Chain Analytics

The project also demonstrates practical SQL development through views, functions, stored procedures, analytical queries, and query performance optimization.

The analysis was performed using the original business datasets, while smaller sample datasets are provided in this repository to keep it lightweight and easy to explore.