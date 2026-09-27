
DELIMITER $$

CREATE PROCEDURE top_n_sales_market(
    IN in_fiscal_year INT,
    IN in_top_n INT
)
BEGIN

    SELECT
        market,
        ROUND(SUM(net_sales), 2) / 1000000 AS net_sales_mln
    FROM gdb041.net_sales
    WHERE fiscal_year = in_fiscal_year
    GROUP BY market
    ORDER BY net_sales_mln DESC
    LIMIT in_top_n;

END$$

DELIMITER ;

