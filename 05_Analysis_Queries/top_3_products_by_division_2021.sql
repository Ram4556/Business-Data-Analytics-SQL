
-- Top 3 products by sold quantity within each division for 2021

WITH cte1 AS
(
    -- Calculate total quantity sold for each product
    SELECT
        p.division,
        p.product,
        SUM(fs.sold_quantity) AS total_qty
    FROM gdb041.fact_sales_monthly AS fs
    JOIN dim_product AS p
        USING (product_code)
    WHERE fiscal_year = 2021
    GROUP BY
        p.division,
        p.product
),

cte2 AS
(
    -- Rank products within each division based on quantity sold
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY division
            ORDER BY total_qty DESC
        ) AS drnk
    FROM cte1
)

SELECT *
FROM cte2
WHERE drnk <= 3;

