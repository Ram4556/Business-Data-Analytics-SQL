CREATE TABLE `pre_invoice_deductions` (
  `customer_code` varchar(255) NOT NULL,
  `fiscal_year` varchar(10) NOT NULL,
  `pre_invoice_discount_pct` decimal(25,20) NOT NULL
) 