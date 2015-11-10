create database nothing;

use nothing;

create table t1 (
	A int,
    B int,
    C int,
    D int
);

create table t2 (
	A int,
    B int,
    C int,
    D int
);

delimiter //
create procedure outer_join()
begin
	declare done int default false;
    declare a, b, c, d int;
	
	

    declare cur cursor for select A, B, C, D from
		(select * from t1 left join t2 using (A, B, C, D)) union
		(select * from t1 right join t2 using (A, B, C, D));
	
    declare continue handler for not found set done = true;

    open cur;

    read_loop: loop
		fetch cur into a, b, c, d;
        select a, b, c, d;
        if done = true then
			leave read_loop;
		end if;
		insert into t1 values (a, b, c, d);
    end loop;

    close cur;
end//
delimiter ;

insert into t1 values(10, 10, 10, 10);
insert into t1 values(10, 10, 10, 20);

insert into t2 values(20, 10, 10, 10);
insert into t2 values(10, 10, 10, 10);

call outer_join();
select * from t1;

drop database nothing;
