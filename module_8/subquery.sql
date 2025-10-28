-- where
-- select
-- from
-- having

select
    name, price
from products
where price > (select avg(price) from products where is_active is true);

select
    users.first_name,
    users.last_name,
    (select count(*) from orders where user_id = users.id) as order_count
from users;
