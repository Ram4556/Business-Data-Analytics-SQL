CREATE VIEW `sales_post_invoice_discount` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `s`.`market` AS `market`,
        `s`.`customer` AS `customer`,
        `s`.`product_code` AS `product_code`,
        `s`.`customer_code` AS `customer_code`,
        `s`.`product` AS `product`,
        `s`.`variant` AS `variant`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `s`.`total_gross_price` AS `total_gross_price`,
        `s`.`pre_invoice_disc_pct` AS `pre_invoice_disc_pct`,
        ((1 - `s`.`pre_invoice_disc_pct`) * `s`.`total_gross_price`) AS `net_invoice_Sales`,
        (`po`.`discounts_pct` + `po`.`other_deductions_pct`) AS `post_invoice_discount_pct`
    FROM
        (`sales_pre_invoice_discount` `s`
        JOIN `gdb056`.`post_invoice_deductions` `po` ON (((`s`.`date` = `po`.`date`)
            AND (`s`.`product_code` = `po`.`product_code`)
            AND (`s`.`customer_code` = `po`.`customer_code`))))