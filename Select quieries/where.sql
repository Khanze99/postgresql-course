
-- where, and, not, or, distinct


-- =, !=, <>

where price = 1000
where price != 1000
where price <> 1000

select name from products where price = 999.99;


-- and, or

select users.first_name, users.email from users
where is_active is true and is_email_verified is true;

-- or

select orders.order_number, orders.status
from orders
where status = 'processing' or status = 'delivered';


-- not

select users.first_name, users.email from users
where is_active is not true;


-- distinct

select distinct orders.status from orders;

select distinct user_addresses.city from user_addresses;