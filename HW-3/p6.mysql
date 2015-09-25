/*
 * In The Name Of God
 * ========================================
 * [] File Name : p6.mysql
 *
 * [] Creation Date : 26-09-2015
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
/*
 * Copyright (c) 2015 Parham Alvani.
*/
create database store;
use store;

create table Product (
	ID int auto_increment,
	name varchar(50),
	price int,
	off int,
	finalprice int,
	primary key (ID)
);

create table Sell (
	ID int auto_increment,
	P_ID int,
	quantity int,
	primary key (ID),
	foreign key (P_ID) references Product(ID)
);

delimiter //
create trigger offer after insert on Sell for each row
begin
	declare sum, p int default 0;
    	declare done int default false;
    	declare cur cursor for select quantity from Sell where Sell.P_ID = new.P_ID;
    	declare continue handler for not found set done = true;
	
    	open cur;

    	read_loop: loop
		fetch cur into p;
        	if done then
			leave read_loop;
		end if;
        	set sum = sum + p;
	end loop;
	
    	if sum >= 30 then
		update Product set off = 30, finalprice = price * 70 / 100 where ID = new.P_ID;
	elseif sum >= 20 then
		update Product set off = 20, finalprice = price * 80 / 100 where ID = new.P_ID;
	elseif sum >= 10 then
		update Product set off = 10, finalprice = price * 90 / 100 where ID = new.P_ID;
	end if;

    	close cur;
end//
delimiter ;

insert into Product (name, price) values
(
	'Pen',
	100
);

select * from Product;

insert into Sell (P_ID, quantity) values
(
	1,
	10
);

select * from Product;

insert into Sell (P_ID, quantity) values
(
	1,
	10
);

select * from Product;

insert into Sell (P_ID, quantity) values
(
	1,
	10
);

select * from Product;

drop database store;
