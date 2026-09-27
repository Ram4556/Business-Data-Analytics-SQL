-- gross sales and pre-invoice discount using lookup tables
-- Lookup tables provide product details, fiscal year,
-- gross price, and customer discount information.

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
JOIN dim_date AS dt
    ON dt.calendar_date = fs.date
JOIN gdb056.gross_price AS gp
    ON gp.product_code = fs.product_code
    AND gp.fiscal_year = dt.fiscal_year
JOIN gdb056.pre_invoice_deductions AS pre
    ON fs.customer_code = pre.customer_code
    AND pre.fiscal_year = dt.fiscal_year
WHERE fs.customer_code = 90002002
  AND dt.fiscal_year = 2021;

