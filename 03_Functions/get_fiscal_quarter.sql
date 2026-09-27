
DELIMITER $$

CREATE FUNCTION get_fiscal_quarter(calendar_date DATE)
RETURNS CHAR(2)
DETERMINISTIC
BEGIN

    RETURN CASE
        WHEN MONTH(calendar_date) IN (9, 10, 11) THEN 'Q1'
        WHEN MONTH(calendar_date) IN (12, 1, 2) THEN 'Q2'
        WHEN MONTH(calendar_date) IN (3, 4, 5) THEN 'Q3'
        ELSE 'Q4'
    END;

END$$

DELIMITER ;
