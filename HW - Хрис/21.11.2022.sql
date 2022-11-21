create database test;

use test;

create table users (
	fname varchar(20),
	lname varchar(20),
	birth_year smallint unsigned
);

show create table users;

alter table users modify column birth_year bigint;

insert into users values ('will', 'smith', 25);

alter table users add column ( 
	birth_date date,
	salary decimal
);

alter table users modify column
	salary decimal(6,2);

alter table users drop column birth_year;

select * from users;

insert into users (fname,lname,birth_date,salary)
	values ('jhon','smith', '1990-11-25', 4500.50);

