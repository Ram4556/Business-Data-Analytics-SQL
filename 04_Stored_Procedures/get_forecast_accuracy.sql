
DELIMITER $$

CREATE PROCEDURE get_forecast_accuracy(IN in_fiscal_year INT)
BEGIN

    WITH forecast_error AS
    (
        SELECT
            s.customer_code,
            SUM(s.sold_quantity) AS total_sold_quantity,
            SUM(s.forecast_quantity) AS total_forecast_quantity,
            SUM(s.forecast_quantity - s.sold_quantity) AS net_error,
            SUM(s.forecast_quantity - s.sold_quantity) * 100
                / SUM(s.forecast_quantity) AS net_error_pct,
            SUM(ABS(s.forecast_quantity - s.sold_quantity)) AS abs_error,
            SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100
                / SUM(s.forecast_quantity) AS abs_error_pct
        FROM gdb041.fact_actual_estimates s
        WHERE s.fiscal_year = in_fiscal_year
        GROUP BY s.customer_code
    )

    SELECT
        e.*,
        c.customer,
        c.market,
        IF(
            100 - e.abs_error_pct < 0,
            0,
            100 - e.abs_error_pct
        ) AS forecast_accuracy
    FROM forecast_error e
    JOIN gdb041.dim_customer c
        USING (customer_code)
    ORDER BY forecast_accuracy DESC;

END$$

DELIMITER ;