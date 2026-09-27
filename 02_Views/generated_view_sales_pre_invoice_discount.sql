CREATE VIEW `sales_pre_invoice_discount` AS
    SELECT 
        `fs`.`date` AS `date`,
        `fs`.`fiscal_year` AS `fiscal_year`,
        `c`.`market` AS `market`,
        `c`.`customer` AS `customer`,
        `fs`.`product_code` AS `product_code`,
        `fs`.`customer_code` AS `customer_code`,
        `fs`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `fs`.`sold_quantity` AS `sold_quantity`,
        `gp`.`gross_price` AS `gross_price`,
        (`fs`.`sold_quantity` * `gp`.`gross_price`) AS `total_gross_price`,
        ROUND(`pre`.`pre_invoice_discount_pct`, 2) AS `pre_invoice_disc_pct`
    FROM
        (((((`fact_sales_monthly` `fs`
        JOIN `dim_customer` `c` ON ((`fs`.`customer_code` = `c`.`customer_code`)))
        JOIN `dim_product` `p` ON ((`fs`.`product_code` = `p`.`product_code`)))
        JOIN `dim_date` `dt` ON ((`dt`.`calendar_date` = `fs`.`date`)))
        JOIN `gdb056`.`gross_price` `gp` ON (((`gp`.`product_code` = `fs`.`product_code`)
            AND (`gp`.`fiscal_year` = `dt`.`fiscal_year`))))
        JOIN `gdb056`.`pre_invoice_deductions` `pre` ON (((`fs`.`customer_code` = `pre`.`customer_code`)
            AND (`pre`.`fiscal_year` = `dt`.`fiscal_year`))))