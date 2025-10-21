-- between
where column between value1 and value2;

select name, price from products where price between 1000 and 5000;
-- in
where column in (value1, value2, ...)

select orders.order_number, orders.status from orders
where status in ('processing', 'delivered');

-- like
where column like 'Pattern'

select name, price from products where name like 'Iphone%';

--ilike
where column like 'pattern'

select name, price from products where name ilike 'iphone%';
