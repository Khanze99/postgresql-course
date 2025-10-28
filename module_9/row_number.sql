-- row_number

select
    orders.user_id,
    orders.order_number,
    orders.created_at,
    row_number() over (partition by orders.user_id order by orders.created_at) as order_seq
from orders
order by user_id, order_seq;