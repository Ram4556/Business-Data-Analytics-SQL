-- Customer net sales and percentage share for fiscal year 2021
WITH cte1 AS(
SELECT
	customer,
	ROUND(SUM(net_sales), 2) / 1000000 AS net_sales_mln
FROM gdb041.net_sales
WHERE fiscal_year = 2021
GROUP BY customer)

SELECT
    *,
    net_sales_mln * 100 / SUM(net_sales_mln) OVER () AS pct
FROM cte1;

