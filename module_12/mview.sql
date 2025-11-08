
create materialized view mvname as
    select columns
    from table
    where conditions;


create materialized view daily_sales as
    select
        orders.created_at::date as sale_date,
        count(*) as orders_count,
        sum(orders.total_amount) as total,
        avg(orders.total_amount) as avg
    from orders
    where status = 'delivered'
    group by created_at::date;

select * from daily_sales;


refresh materialized view concurrently daily_sales;

create or replace function refresh_daily_sales()
returns void as $$
begin
    refresh materialized view concurrently daily_sales;
end;
$$ language plpgsql;
