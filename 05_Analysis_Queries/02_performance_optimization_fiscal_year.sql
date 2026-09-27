
-- Performance optimization by using fiscal_year from fact_sales_monthly
-- Use the existing fiscal_year column to avoid recalculating it
-- while joining lookup tables.

SELECT
    fs.date,
    fs.product,
    p.variant,
    fs.sold_quantity,
    gp.gross_price,
    fs.sold_quantity * gp.gross_price AS total_gross_price,
    ROUND(pre.pre_invoice_discount_pct, 2) AS pre_invoice_disc_pct
FROM fact_sales_monthly AS fs
JOIN dim_product AS p
    USING (product_code)
JOIN gdb056.gross_price AS gp
    ON gp.product_code = fs.product_code
    AND gp.fiscal_year = fs.fiscal_year
JOIN gdb056.pre_invoice_deductions AS pre
    ON fs.customer_code = pre.customer_code
    AND pre.fiscal_year = fs.fiscal_year
WHERE fs.customer_code = 90002002
  AND fs.fiscal_year = 2021;
