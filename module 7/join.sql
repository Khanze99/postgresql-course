-- inner join

select * from products p inner join categories c on c.id = p.category_id;

-- right join

select * from products p right join categories c on c.id = p.category_id;

-- left right

select * from categories c left join products p on c.id = p.category_id;


-- full join

create temp table store(
    id serial primary key,
    name varchar(10)
);

insert into store (name)
values
    ('Пятерочка'),
    ('Магнит'),
    ('Гастроном'),
    ('ВкусВилл');

create temp table product(
    id serial primary key,
    store_id int,
    name varchar(10)
);

insert into product (store_id, name)
values
    (1, 'Яблоко'),
    (1, 'Банан'),
    (2, 'Киви'),
    (null, 'Манго');

select * from product full join pg_temp.store s on s.id = product.store_id;


-- cross join декартово произведение

select * from product p cross join pg_temp.store s;


-- natural join

CREATE TEMP TABLE employees (
    id INT,
    name TEXT,
    department_id INT
);

CREATE TEMP TABLE departments (
    id INT,
    name TEXT,
    location TEXT
);

INSERT INTO employees VALUES
(1, 'IT', 100),
(2, 'HR', 200),
(3, 'Finance', 300);

INSERT INTO departments VALUES
(1, 'IT', 'Moscow'),
(2, 'HR', 'SPB'),
(3, 'Finance', 'Kazan');

select * from employees natural join departments;
