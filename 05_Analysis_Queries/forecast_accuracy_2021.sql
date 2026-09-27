
-- Forecast error analysis by product for fiscal year 2021

SELECT
    date,
    customer_code,
    product_code,
    sold_quantity,
    forecast_quantity,

    SUM(forecast_quantity - sold_quantity) AS net_error,

    SUM(forecast_quantity - sold_quantity) * 100
        / SUM(forecast_quantity) AS net_error_pct,

    SUM(ABS(forecast_quantity - sold_quantity)) AS abs_error,

    SUM(ABS(forecast_quantity - sold_quantity)) * 100
        / SUM(forecast_quantity) AS abs_error_pct

FROM gdb041.fact_actual_estimates AS s
WHERE s.fiscal_year = 2021
GROUP BY
    date,
    customer_code,
    product_code
ORDER BY
    date;

