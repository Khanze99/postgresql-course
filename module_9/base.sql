-- partition by
-- order by
-- frame

-- ранжирование, скользящее среднее

-- function([args]) over (
--     [partition by partition_expression]
--     [order by sort_expression [ASC | DESC]]
--     [FRAME]
-- )


--

select
    user_id,
    order_number,
    total_amount,
    avg(orders.total_amount) over (partition by user_id) as avg_user_order
from orders
where status = 'delivered';