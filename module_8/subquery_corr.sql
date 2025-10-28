

select
    users.first_name,
    users.last_name,
    coalesce((
        select orders.order_number from orders where user_id = users.id order by created_at desc limit 1
    ), 'Заказов не найдено') as last_order
from users;


select
    p1.name,
    p1.price,
    (
        select avg(price) from products p2 where p2.category_id = p1.category_id
    ) as avg_price
from products p1
where price > (
    select avg(price) from products p3 where p3.category_id = p1.category_id
    );

