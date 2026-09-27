CREATE TABLE `dim_customer` (
  `customer` varchar(255) NOT NULL,
  `market` varchar(255) NOT NULL,
  `platform` varchar(255) NOT NULL,
  `channel` varchar(255) NOT NULL,
  `customer_code` varchar(255) NOT NULL,
  PRIMARY KEY (`customer_code`)
)