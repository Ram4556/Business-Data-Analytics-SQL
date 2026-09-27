
DELIMITER $$

CREATE PROCEDURE top_n_sales_customers(
    IN in_top_n INT,
    IN in_fiscal_year INT,
    IN in_market VARCHAR(45)
)
BEGIN

    SELECT
        customer,
        ROUND(SUM(net_sales), 2) / 1000000 AS net_sales_mln
    FROM gdb041.net_sales
    WHERE fiscal_year = in_fiscal_year
      AND market = in_market
    GROUP BY customer
    ORDER BY net_sales_mln DESC
    LIMIT in_top_n;

END$$

DELIMITER ;

