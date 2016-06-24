/*
 * In The Name Of God
 * ========================================
 * [] File Name : trigger.sql
 *
 * [] Creation Date : 24-06-2016
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2016 Parham Alvani.
*/
DELIMITER $$

create trigger doctorRef before insert on medicalhistory
for each row
begin
	if new.doctorID not in (select doctorID from doctor) then
		SIGNAL sqlstate '45001' set message_text = "No way ! You cannot do this !";
	end if;
end $$

DELIMITER ;
