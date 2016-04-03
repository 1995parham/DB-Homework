/*
 * In The Name Of God
 * ========================================
 * [] File Name : p1.mysql
 *
 * [] Creation Date : 04-01-2016
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2016 Parham Alvani.
*/
create table if not exists employes
(
	id int,
    	name varchar(255),
    	family varchar(255),
    	salary int,
    	primary key(id)
);


DELIMITER $$

drop procedure if exists evens;

create procedure evens (in n1 int, in n2 int, out count int)
begin
	declare i int;
    	set i = n1;
    	set count = 0;

    	while i <= n2 do
		if i % 2 = 0 then
			set count = count + 1;
		end if;
		set i = i + 1;
	end while;
end$$

DELIMITER ;

call evens(10, 12, @count);
select @count;

/* Remove comment in order to delete employee_* procedures before creating them */
/*
drop procedure employee_insert;
drop procedure employee_delete;
drop procedure employee_update;
drop procedure employee_select;
*/

DELIMITER $$

create procedure employee_insert (in id int, in name varchar(255), in family varchar(255), in salary int)
begin
	insert into employes values (id, name, family, salary);
end$$

create procedure employee_delete (in id int)
begin
	delete from employes where employes.id = id;
end$$

create procedure employee_update (in id int, in name varchar(255), in family varchar(255), in salary int)
begin
	update employes set employes.name = name, employes.family = family, employes.salary = salary where employes.id = id;
end$$

create procedure employee_select (in c char(1))
begin
	select * from employes where employes.name like concat(c, '%', '');
end$$

DELIMITER ;

call employee_insert(3, 'Parham', 'Alvani', 100);
call employee_insert(1, 'HamidReza', 'Alvani', 100);
call employee_select('P');
call employee_delete(1);
call employee_delete(3);
