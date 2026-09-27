
-- Forecast accuracy for fiscal year 2021

CREATE TEMPORARY TABLE forecast_error_21 AS
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
FROM gdb041.fact_actual_estimates AS s
WHERE s.fiscal_year = 2021
GROUP BY s.customer_code;


CREATE TEMPORARY TABLE forecast_accuracy_21 AS
SELECT
    e.*,
    c.customer,
    c.market,
    IF(
        100 - e.abs_error_pct < 0,
        0,
        100 - e.abs_error_pct
    ) AS forecast_accuracy
FROM forecast_error_21 AS e
JOIN gdb041.dim_customer AS c
    USING (customer_code)
ORDER BY forecast_accuracy DESC;


-- Forecast accuracy for fiscal year 2020

CREATE TEMPORARY TABLE forecast_error_20 AS
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
FROM gdb041.fact_actual_estimates AS s
WHERE s.fiscal_year = 2020
GROUP BY s.customer_code;


CREATE TEMPORARY TABLE forecast_accuracy_20 AS
SELECT
    e.*,
    c.customer,
    c.market,
    IF(
        100 - e.abs_error_pct < 0,
        0,
        100 - e.abs_error_pct
    ) AS forecast_accuracy
FROM forecast_error_20 AS e
JOIN gdb041.dim_customer AS c
    USING (customer_code)
ORDER BY forecast_accuracy DESC;


-- Compare forecast accuracy between 2020 and 2021

WITH cte1 AS
(
    SELECT
        f20.customer_code,
        f20.customer,
        f20.market,
        f20.forecast_accuracy AS forecast_accuracy_2020,
        f21.forecast_accuracy AS forecast_accuracy_2021
    FROM forecast_accuracy_20 AS f20
    JOIN forecast_accuracy_21 AS f21
        USING (customer_code)
)

SELECT *
FROM cte1
WHERE forecast_accuracy_2020 > forecast_accuracy_2021;

