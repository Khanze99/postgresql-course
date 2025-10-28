-- sum, avg

select
    orders.order_number,
    orders.created_at::date as order_date,
    orders.total_amount,
    sum(orders.total_amount) over (order by orders.created_at) as running_total
from orders
where status = 'delivered';

-- avg

select
    orders.order_number,
    orders.total_amount,
    avg(orders.total_amount) over (order by orders.created_at rows between 2 preceding and current row ) as moving_avg_3
from orders
where status = 'delivered';