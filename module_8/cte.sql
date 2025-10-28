-- cte - common table expression

with user_stats as (
    select orders.user_id, count(*) as total_orders, sum(orders.total_amount) as total_spent
    from orders
    where status = 'delivered'
    group by orders.user_id
)

select users.first_name, users.last_name, coalesce(us.total_orders, 0) as orders, coalesce(us.total_spent) as spent
from users left join user_stats us on users.id = us.user_id;


with
    product_sales as (
        select order_items.product_id,
               sum(order_items.quantity) as total_sold
        from order_items
        group by order_items.product_id
    ),
    category_stats as (
        select
            c.name as category_name,
            count(p.id) as product_count,
            sum(ps.total_sold) as sold
        from categories c
        left join products p on c.id = p.category_id
        left join product_sales ps on p.id = ps.product_id
        group by c.id, c.name
    )

select * from category_stats order by sold desc;