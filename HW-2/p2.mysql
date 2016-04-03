/*
 * In The Name Of God
 * ========================================
 * [] File Name : p2.mysql
 *
 * [] Creation Date : 04-01-2016
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2016 Parham Alvani.
*/
DELIMITER $$

create function outputGenerator(input varchar(255)) returns varchar(255)
	deterministic
begin
	declare ratval varchar(255);

    	set retval = '';

	case
		when input = '۸۱۱' then
			set retval = '-فروردین ۱۳۸۸-';
		when input = '۸۴۱' then
			set retval = '-تیر ۱۳۸۸-';
        	when input = '۸۶۱' then
			set retval = '-شهریور ۱۳۸۸-';
    	end case;
	return (retval);
end$$


create function primeChecker(input int) returns bool
	deterministic
begin
	declare i int;
    	declare retval bool;

    	set retval = true;
    	set i = 2;

    	while i < input do
        	if input % i = 0 then
			set retval = false;
		end if;
        	set i = i + 1;
    	end while;
    	return (retval);
end$$
