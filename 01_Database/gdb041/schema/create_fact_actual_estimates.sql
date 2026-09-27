CREATE TABLE `fact_actual_estimates` (
  `date` datetime NOT NULL,
  `fiscal_year` year DEFAULT NULL,
  `customer_code` varchar(255) NOT NULL DEFAULT '',
  `product_code` varchar(255) NOT NULL DEFAULT '',
  `sold_quantity` int DEFAULT NULL,
  `forecast_quantity` int DEFAULT NULL,
  PRIMARY KEY (`date`,`customer_code`,`product_code`)
) 