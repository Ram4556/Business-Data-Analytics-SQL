
DELIMITER $$

CREATE PROCEDURE monthly_customer_sales(IN c_codes TEXT)
BEGIN

    SELECT
        fs.date,
        ROUND(SUM(gp.gross_price * fs.sold_quantity), 2) AS total_gross_price
    FROM fact_sales_monthly AS fs
    JOIN gdb056.gross_price AS gp
        ON gp.product_code = fs.product_code
        AND gp.fiscal_year = get_fiscal_year(fs.date)
    WHERE FIND_IN_SET(fs.customer_code, c_codes)
    GROUP BY fs.date
    ORDER BY fs.date ASC;

END$$

DELIMITER ;