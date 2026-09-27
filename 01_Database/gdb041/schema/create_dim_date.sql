CREATE TABLE `dim_date` (
  `calendar_date` date NOT NULL,
  `fiscal_year` year GENERATED ALWAYS AS (year((`calendar_date` + interval 4 month))) VIRTUAL,
  PRIMARY KEY (`calendar_date`)
) 