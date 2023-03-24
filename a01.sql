-- Basic database operations ----- --

create database thing;
use  thing;
alter database thing read only = 1; 
drop database thing;
alter database thing read only = 0;
drop database thing;

-- basic table operations -------- --

create database test_hr;
use test_hr;

Create Table employees(
	employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    hourly_pay decimal(5, 2),
    hire_date date
);

select * from employees;
rename table employees to workers;
rename table workers to employees;

alter table employees 
	add -- add new column
		phone_number varchar(15);

alter table employees 
	rename column 
		phone_number to email;

alter table employees
	modify column
		email varchar(100);

alter table employees
	modify 
		email varchar(100)
	after last_name;

alter table employees
	drop column 
		email;

-- inserting values ---- --

insert into employees
	values(
		1, 
        "Eugene",
        "Krabs",
        25.50,
        "2023-01-02"
    );

insert into employees
	values	(2, "Squidward", "Tentacles", 15.00, "2023-01-03"),
			(3, "Spongebob", "Squarepants", 12.50, "2023-01-04"),
            (4, "Patrick", "Star", 12.50, "2023-01-05"),
            (5, "Sandy", "Cheeks", 17.50, "2023-01-06");
            
insert into employees(employee_id, first_name, last_name)
	values(6, "Sheldon", "Plankton");
    
select * from employees;

-- Selecting values ---- --

select 
	first_name, last_name, first_name
from employees;

select * 
from employees
where employee_id <= 4;

select * 
from employees
where hire_date is null;

-- Altering data ------ --

update employees 
set hourly_pay = 10.25,
	hire_date = "2023-01-07"
where employee_id = 6;

delete from employees
where employee_id = 6;

select * from employees;

-- Constraints -----------------

create table products(
	product_id int,
    product_name varchar(25) unique,
    price decimal(4, 2)
);

alter table products
	add constraint
		unique(product_name);

insert into products
	values	(100, "Hamburger", 3.99),
			(101, "Fries", 1.89),
            (102, "Soda",  1.00),
            (103, "Ice Cream", 1.49);
            
alter table products
	modify price
		decimal(4, 2) not null;
		
select * from products;

alter table employees
	add constraint chk_hourly_pay 
		check(hourly_pay >= 10);

select * from employees;

alter table employees
	drop check chk_hourly_pay;
    
-- Default --------------------

insert into products
	values	(104, "straw"),
			(105, "napkin"),
            (106, "fork"),
            (107, "spoon");
            
select * from products;

delete from products
	where product_id > 103;

alter table products 
	alter price
		set default 0;

insert into products (product_id, product_name)
	values	(104, "straw"),
			(105, "napkin"),
            (106, "fork"),
            (107, "spoon");
            
-- Primary key ------------------

create table transactions(
	transaction_id int,
    amount decimal (5, 2)
);

select * from transactions;

alter table transactions
	add constraint 
		primary key(transaction_id);
        
insert into transactions
	values	(1001, 3.38),
			(1002, 4.95),
            (1003, 5,54)