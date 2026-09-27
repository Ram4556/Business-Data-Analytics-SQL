
DELIMITER $$

CREATE PROCEDURE top_n_products_division_qty_sold(
    IN in_top_n INT,
    IN in_fiscal_year INT
)
BEGIN

    WITH cte1 AS
    (
        SELECT
            p.division,
            p.product,
            SUM(fs.sold_quantity) AS total_qty
        FROM gdb041.fact_sales_monthly AS fs
        JOIN dim_product AS p
            USING (product_code)
        WHERE fiscal_year = in_fiscal_year
        GROUP BY
            p.division,
            p.product
    ),

    cte2 AS
    (
        SELECT
            *,
            DENSE_RANK() OVER (
                PARTITION BY division
                ORDER BY total_qty DESC
            ) AS top_n
        FROM cte1
    )

    SELECT *
    FROM cte2
    WHERE top_n <= in_top_n;

END$$

DELIMITER ;

