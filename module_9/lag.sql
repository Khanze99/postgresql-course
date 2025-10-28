-- LAG() и LEAD()

select
    user_id,
    order_number,
    total_amount,
    lag(orders.total_amount) over (partition by orders.user_id order by orders.created_at) as prev_orver_amount,
    orders.total_amount - lag(orders.total_amount) over (partition by orders.user_id order by orders.created_at) as diff_from_prev
from orders
where status = 'delivered';