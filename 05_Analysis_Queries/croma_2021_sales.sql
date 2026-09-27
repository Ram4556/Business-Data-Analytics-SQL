-- Gross sales by product for customer 90002002 in fiscal year 2021
SELECT
    fs.date, fs.product, p.variant, fs.sold_quantity, gp.gross_price, fs.sold_quantity * gp.gross_price AS total_gross_price
FROM fact_sales_monthly AS fs
JOIN dim_product AS p
    USING (product_code)
JOIN gdb056.gross_price AS gp
    ON gp.product_code = fs.product_code
    AND gp.fiscal_year = get_fiscal_year(fs.date)
WHERE customer_code = 90002002
  AND get_fiscal_year(fs.date) = 2021;
