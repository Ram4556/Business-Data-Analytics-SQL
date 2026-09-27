CREATE VIEW `net_sales` AS
    SELECT 
        `sales_post_invoice_discount`.`date` AS `date`,
        `sales_post_invoice_discount`.`fiscal_year` AS `fiscal_year`,
        `sales_post_invoice_discount`.`market` AS `market`,
        `sales_post_invoice_discount`.`customer` AS `customer`,
        `sales_post_invoice_discount`.`product_code` AS `product_code`,
        `sales_post_invoice_discount`.`customer_code` AS `customer_code`,
        `sales_post_invoice_discount`.`product` AS `product`,
        `sales_post_invoice_discount`.`variant` AS `variant`,
        `sales_post_invoice_discount`.`sold_quantity` AS `sold_quantity`,
        `sales_post_invoice_discount`.`total_gross_price` AS `total_gross_price`,
        `sales_post_invoice_discount`.`pre_invoice_disc_pct` AS `pre_invoice_disc_pct`,
        `sales_post_invoice_discount`.`net_invoice_Sales` AS `net_invoice_Sales`,
        `sales_post_invoice_discount`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        ((1 - `sales_post_invoice_discount`.`post_invoice_discount_pct`) * `sales_post_invoice_discount`.`net_invoice_Sales`) AS `net_sales`
    FROM
        `sales_post_invoice_discount`