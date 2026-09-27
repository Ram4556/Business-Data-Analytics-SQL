CREATE TABLE `fact_forecast_monthly` (
  `date` datetime NOT NULL,
  `fiscal_year` year GENERATED ALWAYS AS (year((`date` + interval 4 month))) VIRTUAL,
  `division` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `product` varchar(255) NOT NULL,
  `market` varchar(255) NOT NULL,
  `platform` varchar(255) NOT NULL,
  `channel` varchar(255) NOT NULL,
  `customer_code` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `forecast_quantity` int NOT NULL
) 