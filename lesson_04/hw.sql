1.

CREATE VIEW locality_info AS 
 
SELECT con.`display_name` AS 'страна', reg.`display_name` AS 'область', 
       dis.`display_name` AS 'район', loc.`display_name` AS 'населенный пункт'

FROM `locality` loc
LEFT JOIN  `district` dis ON loc.`district_id` = dis.`id`
LEFT JOIN  `region` reg ON loc.`region_id` = reg.`id`
LEFT JOIN  `country` con ON reg.`country_id` = con.`id`;

2.

DELIMITER $$
 
DROP FUNCTION IF EXISTS GetManagerId $$
 
CREATE FUNCTION GetManagerId(p_name VARCHAR(50), p_last_name VARCHAR(50)) RETURNS BIGINT(20)
    DETERMINISTIC
BEGIN
    DECLARE man_id BIGINT(20);
    
    SET man_id = NULL;
    
    SELECT id INTO man_id FROM staff 
    WHERE
    `lastname` LIKE p_last_name AND
    `name` LIKE p_name
    LIMIT 1;

    RETURN man_id;
END;


3.

DELIMITER $$

DROP TRIGGER IF EXISTS staff_after_insert$$

CREATE TRIGGER staff_after_insert
AFTER INSERT
   ON staff FOR EACH ROW

BEGIN

   INSERT INTO payment
    (staff_id,amount)
   VALUES 
    (NEW.id,10000);

END;
