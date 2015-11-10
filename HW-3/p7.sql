create database airport;

create table Flight (
	Flight_num int,
	Flight_date varchar(50),
	Flight_from varchar(50),
	Flight_to varchar(50),
	Capacity smallint,
	primary Key (Flight_num, Flight_date)
);

create table Ticket (
	Ticket_num varchar(50),
	Passenger_num varchar(50),
	First_name nvarchar(50),
	Last_name nvarchar(50),
	Flight_num int,
	Flight_date varchar(50),
	Foreign Key (Flight_num, Flight_date) references Flight,
    primary Key (Ticket_num)
);


delimiter //

delimiter ;

delimiter //
create procedure reserve(
	in Ticket_num varchar(50),
	in Passenger_num varchar(50),
	in First_name nvarchar(50),
	in Last_name nvarchar(50),
	in Flight_num int,
	in Flight_date varchar(50))
begin
	declare exit handler for SQLException
	begin
		rollback;
		select "An error was occured";
	end;
	start transaction;
		insert into Ticket values(
			Ticket_num,
            Passenger_num,
            First_name,
            Last_name,
            Flight_num,
            Flight_date
        );
    commit;
end//
delimiter ;

delimiter //
create procedure free(in Ticket_num varchar(50))
begin
    declare exit handler for SQLException
	begin
		rollback;
		select "An error was occured";
	end;
	start transaction;
		delete from Ticket where Ticket.Ticket_num = Ticket_num;
    commit;
end//
delimiter ;

drop database airport;