
DELIMITER //
CREATE FUNCTION secs_transformation(a INT)
RETURNS  VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE days INT;
DECLARE hours INT;
DECLARE mins INT;
DECLARE secs INT;
CASE
	WHEN a > 86400
THEN
SET days = Truncate(a/86400,0);
SET hours = Truncate((a - days*86400)/3600,0);
SET mins = Truncate ((a - days*86400 - hours * 3600)/60,0);
SET secs = a - days*86400 - hours*3600 - mins*60;
RETURN CONCAT (days, 'days', hours, 'hours', mins, 'minutes', secs, 'seconds');
	WHEN 3600 < a <= 86400
THEN 
SET hours = TRUNCATE(a/3600,0);
SET mins = TRUNCATE((a - hours*3600)/60,0);
SET secs = a - hours*3600 - mins*60;
RETURN CONCAT (hours, 'hours', mins, 'minutes', secs, 'seconds');
	WHEN 60 < a <= 3600
THEN
SET mins = TRUNCATE (( a/3600),0);
SET secs = a - mins*60;
RETURN CONCAT ( mins, 'minutes', secs, 'seconds');
	WHEN 0 < a <=60
THEN RETURN CONCAT(a,'seconds');

END CASE;
END //
SELECT secs_transformation(124414) AS 'Result'

-- DELIMITER $$
-- CREATE PROCEDURE even_numbers()
-- BEGIN
--     DECLARE n INT default 0;
--     DROP TABLE IF EXISTS nums;
--     CREATE TABLE nums (n INT);

--     WHILE n < 10 DO
--     SET n = n + 2;
--     INSERT INTO nums VALUES(n);
--     END WHILE;

-- SELECT * FROM nums;
-- END $$
-- DELIMITER ;
-- CALL even_numbers();




