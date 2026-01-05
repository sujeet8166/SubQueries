## Firts to create table of (Employees Dataset, Department Dataset, Sales Dataset) we have to create a database with any name you want (i'm creating database with SubQueries name) and then in SubQueries database we create sample tables

create database SubQueries;
use SubQueries;

## Employees Dataset:

create table Employees (
  emp_id int,
  name varchar(20),
  department_id char(3),
  salary int);
  
  
insert into Employees 
values(101, "Abhishek", "D01'", 62000),
(102, "Shubham", "D01", 58000),
(103, "Priya", "D02", 67000),
(104, "Rohit", "D02", 64000),
(105, "Neha", "D03", 72000),
(106, "Aman", "D03", 55000),
(107, "Ravi", "D04", 60000),
(108, "Sneha", "D04", 75000),
(109, "Kiran", "D05", 70000),
(110, "Tanuja", "D05", 65000);
  

## Departments


create table Departments (
  department_id char(3),
  department_name varchar(15),
  location varchar(20));
  

insert into Departments 
values ("D01", "Sales", "Mumbai"),
("D02", "Marketing", "Delhi"),
("D03", "Finance", "Pune"),
("D04", "HR", "Bengaluru"),
("D05", "IT", "Hyderabad");


## Sales


create table Sales (
  sale_id int,
  emp_id int,
  sale_amount int,
  sale_date date);


insert into Sales 
values (201, 101, 4500, "2025-01-05"),
(202, 102, 7800, "2025-01-10"),
(203, 103, 6700, "2025-01-14"),
(204, 104, 12000, "2025-01-20"),
(205, 105, 9800, "2025-02-02"),
(206, 106, 10500, "2025-02-05"),
(207, 107, 3200, "2025-02-09"),
(208, 108, 5100, "2025-02-15"),
(209, 109, 3900, "2025-02-20"),
(210, 110, 7200, "2025-03-01");


##  Queries

# BASIC LEVEL

## Q1: Employees earning more than average salary
select name
from Employees
where salary > (select avg(salary) from Employees);

## Q2: Employees in department with highest average salary
select name
from Employees
where department_id = (
  select department_id
  from Employees
  group by department_id
  order by avg(salary) desc
  limit 1);

## Q3: Employees who made at least one sale
select name
from Employees
where emp_id in (select distinct emp_id from Sales);

## Q4: Employee with highest sale amount
select name
from Employees
where emp_id = (
  select emp_id
  from Sales
  order by sale_amount desc
  limit 1);

## Q5: Employees whose salary > Shubham's salary
select name
from Employees
where salary > (select salary from Employees where name="Shubham");

# INTERMEDIATE LEVEL

## Q1: Employees in same department as Abhishek
select name
from Employees
where department_id = (
  select department_id from Employees where name="Abhishek");

## Q2: Departments with at least one employee earning > 60000
select distinct d.department_name
from Departments d
where d.department_id in (
  select department_id from Employees where salary > 60000);

## Q3: Department name of employee with highest sale
select department_name
from Departments
where department_id = (
  select department_id
  from Employees
  where emp_id = (
    select emp_id from Sales order by sale_amount desc limit 1));

## Q4: Employees with sales greater than average sale amount
select name
from Employees
where emp_id in (
  select emp_id from Sales where sale_amount > (select avg(sale_amount) from Sales));

## Q5: Total sales by employees earning more than average salary
select sum(sale_amount) as TotalSales
from Sales
where emp_id in (
  select emp_id from Employees where salary > (select avg(salary) from Employees));

# ADVANCED LEVEL

## Q1: Employees who have not made any sales
select name
from Employees
where emp_id not in (select distinct emp_id from Sales);

## Q2: Departments where average salary > 55000
select department_name
from Departments
where department_id in (
  select department_id from Employees group by department_id having avg(salary) > 55000);

## Q3: Departments where total sales > 10000
select department_name
from Departments
where department_id in (
  select e.department_id
  from Employees e
  join Sales s on e.emp_id = s.emp_id
  group by e.department_id
  having sum(s.sale_amount) > 10000);

## Q4: Employee with second-highest sale
select name
from Employees
where emp_id = (
  select emp_id
  from Sales
  order by sale_amount desc
  limit 1 offset 1);

## Q5: Employees whose salary > highest sale amount
select name
from Employees
where salary > (select max(sale_amount) from Sales);

