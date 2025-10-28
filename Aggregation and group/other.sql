-- rollup, grouping(), group by cube, group by grouping sets

-- Создаем таблицу продаж
CREATE TABLE sales (
    city VARCHAR(50),
    store VARCHAR(50),
    product VARCHAR(50),
    sales_amount DECIMAL(10,2),
    sale_date DATE
);

-- rollup
select sales.city, sales.store, sum(sales.sales_amount) from sales group by rollup (city, store) order by city, store;

-- grouping
select
    sales.city,
    sales.store,
    grouping(sales.city) as result_city,
    grouping(sales.store) as result_store,
    sum(sales.sales_amount) as common_sum
from sales
group by rollup (city, store)
order by city, store;


-- cube, sets
select
    sales.city,
    sales.product,
    sum(sales.sales_amount) as sum
from sales
group by cube (city, product)
order by city, product;

select
    sales.city,
    sales.product,
    sum(sales.sales_amount) as sum
from sales
group by grouping sets (
    (city, product), -- detail data
    (city), -- only city
    ()  -- common result
    )
order by city, product;

-- Наполняем данными
INSERT INTO sales (city, store, product, sales_amount, sale_date) VALUES
('Москва', 'Магазин1', 'Яблоки', 100.00, '2024-01-15'),
('Москва', 'Магазин1', 'Груши', 150.00, '2024-01-16'),
('Москва', 'Магазин2', 'Яблоки', 80.00, '2024-01-15'),
('СПб', 'Магазин3', 'Яблоки', 120.00, '2024-01-17'),
('Москва', 'Магазин1', 'Яблоки', 90.00, '2024-02-10'),
('Москва', 'Магазин2', 'Бананы', 200.00, '2024-02-11'),
('СПб', 'Магазин3', 'Груши', 180.00, '2024-02-12'),
('Москва', 'Магазин1', 'Бананы', 120.00, '2024-02-13');

select * from sales;


CREATE TABLE users_demo (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    is_active BOOLEAN,
    is_email_verified BOOLEAN,
    created_at DATE,
    age_group VARCHAR(20)
);

-- Наполняем тестовыми данными
INSERT INTO users_demo (first_name, last_name, city, is_active, is_email_verified, created_at, age_group) VALUES
('Иван', 'Петров', 'Москва', true, true, '2024-01-15', '18-25'),
('Мария', 'Иванова', 'Москва', true, false, '2024-01-16', '26-35'),
('Алексей', 'Сидоров', 'СПб', true, true, '2024-01-17', '36-45'),
('Ольга', 'Кузнецова', 'Москва', false, true, '2024-01-18', '18-25'),
('Дмитрий', 'Смирнов', 'СПб', true, false, '2024-02-10', '26-35'),
('Елена', 'Попова', 'Москва', true, true, '2024-02-11', '36-45'),
('Сергей', 'Васильев', 'Москва', false, false, '2024-02-12', '18-25'),
('Анна', 'Новикова', 'СПб', true, true, '2024-02-13', '26-35'),
('Павел', 'Федоров', 'Москва', true, true, '2024-03-01', '36-45'),
('Ирина', 'Морозова', 'СПб', true, false, '2024-03-02', '18-25');


-- Создаем таблицу сотрудников
drop table employees;
CREATE TABLE employees (
    department VARCHAR(50),
    position VARCHAR(50),
    gender VARCHAR(10),
    salary DECIMAL(10,2),
    experience_years INTEGER
);

-- Наполняем данными
INSERT INTO employees (department, position, gender, salary, experience_years) VALUES
('IT', 'Разработчик', 'Мужской', 150000, 3),
('IT', 'Разработчик', 'Женский', 140000, 2),
('IT', 'Тестировщик', 'Мужской', 90000, 1),
('IT', 'Тестировщик', 'Женский', 95000, 2),
('Маркетинг', 'Менеджер', 'Мужской', 120000, 4),
('Маркетинг', 'Менеджер', 'Женский', 110000, 3),
('Маркетинг', 'Аналитик', 'Мужской', 130000, 5),
('Маркетинг', 'Аналитик', 'Женский', 125000, 4),
('Продажи', 'Менеджер', 'Мужской', 100000, 2),
('Продажи', 'Менеджер', 'Женский', 105000, 3);

select
    employees.position,
    count(*)
from employees
group by position;