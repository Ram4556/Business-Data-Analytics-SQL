

DELIMITER $$

CREATE PROCEDURE top_n_sales_product(
    IN in_fiscal_year INT,
    IN in_top_n INT
)
BEGIN

    SELECT
        net_sales.product,
        ROUND(SUM(net_sales)/ 1000000,2)  AS net_sales_mln
    FROM gdb041.net_sales
    WHERE fiscal_year = in_fiscal_year
    GROUP BY product
    ORDER BY net_sales_mln DESC
    LIMIT in_top_n;

END$$

DELIMITER ;

