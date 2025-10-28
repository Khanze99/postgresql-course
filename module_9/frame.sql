-- frame

WITH orders_example AS (
    SELECT 'ORD-001' as order_number, 1000 as total_amount, 1 as seq UNION ALL
    SELECT 'ORD-002' as order_number, 1500 as total_amount, 2 as seq UNION ALL
    SELECT 'ORD-003' as order_number, 800 as total_amount, 3 as seq UNION ALL
    SELECT 'ORD-004' as order_number, 2000 as total_amount, 4 as seq UNION ALL
    SELECT 'ORD-005' as order_number, 1200 as total_amount, 5 as seq
)
SELECT
        -- 1. Текущая и все предыдущие строки
    SUM(total_amount) OVER (
        ORDER BY seq
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as running_total,

    -- 2. 2 предыдущие строки и текущая
    AVG(total_amount) OVER (
        ORDER BY seq
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as avg_3_last,

    -- 3. Текущая и 1 следующая строка
    SUM(total_amount) OVER (
        ORDER BY seq
        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
    ) as current_and_next,

    -- 4. Все строки в окне
    SUM(total_amount) OVER (
        ORDER BY seq
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as total_all_orders,

    -- 5. 1 предыдущая, текущая и 1 следующая
    AVG(total_amount) OVER (
        ORDER BY seq
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) as centered_avg

FROM orders_example
ORDER BY seq;

-- frame rows

-- unbounded preceding - начало/до текущей
-- N preceding - кол-во перед текущей
-- current row - текущая
-- N following - кол-во после текущей
-- unbounded following - конец окна/все после текущей далее
