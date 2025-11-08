-- View - представление

create view viewname as
    select columns
    from table
    where conditions;


create view user_order_stats as
    select
        u.id,
        u.first_name,
        u.last_name,
        u.email,
        count(o.id) as total_orders,
        sum(o.total_amount) as total_amount,
        max(o.created_at) as last_order_date
from users u
left join public.orders o on u.id = o.user_id
group by u.id, u.first_name, u.last_name, u.email;

select * from user_order_stats;


-- упрощение сложных запросов
-- сокрытие сложности схемы данных
-- контроль доступа к данным
-- единооборазие доступа


-- нужные всегда актуальные данные
-- запрос выполняется быстро

