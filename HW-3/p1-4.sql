create database university;
use university;

create table Students (
	ID int auto_increment,
	Name varchar(50),
	Family varchar(50),
	Average Float default 0.0,
	Primary key (ID)
);

create table Courses (
	ID int auto_increment,
    Name varchar(50),
    Primary key (ID)
);

create table StudentCourses (
	STD_ID int,
	course_ID int,
	Grade Float,
    AlphabeticGrade char default 'F',
	primary key (Std_id,course_id),
	Foreign key (Std_id) references Students(ID),
	Foreign key (course_id) references Courses(ID)
);

create table LogTable (
	ID int auto_increment,
	Students_Log varchar(50),
    Courses_Log varchar(50),
    StudentCourses varchar(50),
    primary key (ID)
);

delimiter //
create trigger average_and_alphabetic_grade before insert on StudentCourses
	for each row
    begin
		/* average */
		select count(STD_ID) into @course_num from StudentCourses, Students where StudentCourses.STD_ID = Students.ID;
		update Students set Students.Average = (Students.Average * @course_num + new.Grade) / (@course_num + 1) where new.STD_ID = Students.ID;
		/* alphabetic_grade */
        if new.Grade > 17 then
			set new.AlphabeticGrade = 'A';
		elseif new.Grade > 14 then
			set new.AlphabeticGrade = 'B';
		elseif new.Grade > 10 then
			set new.AlphabeticGrade = 'C';
		else
			set new.AlphabeticGrade = 'F';
		end if;
    end//
delimiter ;

create trigger students_insert_log after insert on Students
	for each row insert into LogTable values (NULL ,'insert', '-', '-');

create trigger students_update_log after update on Students
	for each row insert into LogTable values (NULL, 'update', '-', '-');

create trigger students_delete_log after delete on Students
	for each row insert into LogTable values (NULL, 'delete', '-', '-');

create trigger courses_insert_log after insert on Courses
	for each row insert into LogTable values (NULL, '-', 'insert', '-');

create trigger courses_update_log after update on Courses
	for each row insert into LogTable values (NULL, '-', 'update', '-');

create trigger courses_delete_log after delete on Courses
	for each row insert into LogTable values (NULL, '-', 'delete', '-');

create trigger studentcourses_insert_log after insert on StudentCourses
	for each row insert into LogTable values (NULL, '-', '-', 'insert');

create trigger studentcourses_update_log after update on StudentCourses
	for each row insert into LogTable values (NULL, '-', '-', 'update');

create trigger studentcourses_delete_log after delete on StudentCourses
	for each row insert into LogTable values (NULL, '-', '-', 'delete');

insert into Students(Name, Family) values (
	'Parham',
	'Alvani'
);

select * from Students;

insert into Courses(Name) values (
	'C'
);

insert into Courses(Name) values (
	'Math-1'
);

insert into Courses(Name) values (
	'Math-2'
);

insert into StudentCourses values (
	1,
    1,
    18,
    NULL
);

insert into StudentCourses values (
	1,
    2,
    19,
    NULL
);

insert into StudentCourses values (
	1,
    3,
    20,
    NULL
);

select * from Students;

select * from LogTable;

select
	Students.Name,
    Students.Family,
    Courses.name,
    StudentCourses.Grade,
    StudentCourses.AlphabeticGrade
from Students, StudentCourses, Courses 
where StudentCourses.STD_ID = Students.ID and StudentCourses.course_ID = Courses.ID;

delimiter //
create procedure average (in id int, out average float)
begin
	declare done int default false;
    declare sum, g float default 0;
    declare counter int default 0;
    declare cur cursor for select grade from StudentCourses where STD_ID = id;
	declare continue handler for not found set done = true;

    open cur;

    read_loop: loop
		fetch cur into g;
        if done then
			leave read_loop;
		end if;
        set sum = sum + g;
        set counter = counter + 1;
	end loop;
    set average = sum / counter;

    close cur;

end//
delimiter ;

call average(1, @result);
select @result;

drop database university;
