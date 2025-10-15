-- DML - Data Manipulation language
-- CRUD (Create, Read, Update, delete)

insert into tablename (column1, column2) values (value1, value2);

create table employees (
    id serial primary key,
    name varchar(100) not null,
    email varchar(100) unique,
    salary numeric(10, 2) default 0,
    hire_date_at date default current_date,
    is_active boolean default true
);

insert into employees (name, email, salary) values ('Иван', 'ivan@mail.ru', 75000.00);

select * from employees;


--

insert into tablename (column1, column2)
values
    (value1, value2),
    (value1, value2),
    (value1, value2),
    (value1, value2);

insert into employees (name, email, salary)
values
('Мария', 'maria@mail.ru', 82000.00),
('Алексей', 'alex@mail.ru', 68000.00),
('Максим', 'max@mail.ru', 91000.00);

select * from employees;

--

insert into targettable (column1, column2)
select source_column1, source_column2 from sourcetable
where condition;


create table archive_employees (
    id serial primary key,
    name varchar(100) not null,
    email varchar(100),
    salary numeric(10, 2),
    archived_at timestamptz default now()
);

insert into archive_employees (name, email, salary)
select name, email, salary from employees
where is_active = false;

select * from archive_employees;


create table high_paid_employees as
select name, email, salary from employees
where salary > 80000;
