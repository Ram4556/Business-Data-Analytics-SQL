
DELIMITER $$

CREATE PROCEDURE market_badge(
    IN fiscal_year YEAR,
    IN in_market VARCHAR(25),
    OUT market_badge CHAR(10)
)
BEGIN

    DECLARE total_qty INT;

    IF in_market = '' THEN
        SET in_market = 'India';
    END IF;

    SELECT
        SUM(sold_quantity)
    INTO total_qty
    FROM fact_sales_monthly
    WHERE get_fiscal_year(date) = fiscal_year
      AND market = in_market
    GROUP BY market;

    IF total_qty >= 5000000 THEN
        SET market_badge = 'Gold';
    ELSE
        SET market_badge = 'Silver';
    END IF;

END$$

DELIMITER ;