CREATE TABLE `post_invoice_deductions` (
  `customer_code` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `discounts_pct` decimal(15,10) NOT NULL,
  `other_deductions_pct` decimal(15,10) NOT NULL
) 