DELIMITER $$

create function outputGenerator(number varchar(255)) returns varchar(255)
	deterministic
begin
	declare ratval varchar(255);

    set retval = '';

	case
		when numebr = '۸۱۱' then set retval = '-فروردین ۱۳۸۸-';
		when number = '۸۴۱' then set retval = '-تیر ۱۳۸۸-';
        when number = '۸۶۱' then set retval = '-شهریور ۱۳۸۸-';
    end case;

    return (retval);
end $$


create function primeChecker(number int) returns bool
	deterministic
begin
	declare i int;
    declare retval bool;

    set retval = true;
    set i = 2;

    while i < number do
        if number % i = 0 then
			set retval = false;
		end if;
        set i = i + 1;
    end while;
    return (retval);
end $$
