
-- Customer net sales and percentage share within each region for 2021

WITH cte1 AS
(
    -- Calculated total net sales for each customer in each region
    SELECT
        ns.customer,
        m.region,
        ROUND(SUM(ns.net_sales), 2) / 1000000 AS net_sales_mln
    FROM gdb041.net_sales AS ns
    JOIN gdb041.dim_market AS m
        USING (market)
    WHERE fiscal_year = 2021
    GROUP BY
        ns.customer,
        m.region
)

-- Calculated each customer's share of the total sales in their region
SELECT
    *,
    net_sales_mln * 100
        / SUM(net_sales_mln) OVER (PARTITION BY region)
        AS pct_share_region
FROM cte1
ORDER BY
    region,
    net_sales_mln DESC;
