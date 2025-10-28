-- first_value, last_value

select
    orders.user_id,
    orders.order_number,
    orders.total_amount,
    first_value(orders.order_number) over (partition by orders.user_id order by orders.created_at) as first_order,
    last_value(orders.order_number) over (
        partition by orders.user_id order by orders.created_at rows between unbounded preceding and unbounded following
        ) as last_order
from orders
where status = 'delivered';