/*
 * In The Name Of God
 * ========================================
 * [] File Name : cursor.sql
 *
 * [] Creation Date : 18-04-2016
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2016 Parham Alvani.
*/

DELIMITER //

CREATE PROCEDURE curdemo()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	
	DECLARE t1_a INT;
	DECLARE t2_a INT;
	
	DECLARE cur1 CURSOR FOR SELECT A FROM test.t1;
	DECLARE cur2 CURSOR FOR SELECT A FROM test.t2;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
	OPEN cur1;
	OPEN cur2;

	l: WHILE TRUE DO
		FETCH cur1 INTO t1_a;
		FETCH cur2 INTO t2_a;

		IF done THEN
			LEAVE l;
		END IF;
	
		IF t1_a < t2_a THEN
			SELECT t1_a as "", " < " as "", t2_a as "";
		ELSE
			SELECT t1_a as "", " >= " as "", t2_a as "";
		END IF;
	END WHILE;

	CLOSE cur1;
	CLOSE cur2;
END//

DELIMITER ;

CALL curdemo();

DROP PROCEDURE curdemo;
