
-- Combining sales and forecast records, including unmatched records from both tables

-- all sales records and matching forecast records
SELECT
    s.date,
    s.fiscal_year,
    s.customer_code,
    s.product_code,
    s.sold_quantity,
    f.forecast_quantity
FROM gdb041.fact_sales_monthly AS s
LEFT JOIN gdb041.fact_forecast_monthly AS f
    USING (date, customer_code, product_code)

UNION ALL

-- forecast records that have no matching sales record
SELECT
    f.date,
    f.fiscal_year,
    f.customer_code,
    f.product_code,
    s.sold_quantity,
    f.forecast_quantity
FROM gdb041.fact_forecast_monthly AS f
LEFT JOIN gdb041.fact_sales_monthly AS s
    USING (date, customer_code, product_code)
WHERE s.product_code IS NULL;

