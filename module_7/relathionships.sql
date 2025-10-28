-- 1 to 1


create table user_profiles (
    user_id uuid primary key references users(id) on delete cascade,
    passport_number varchar(20) unique,
    passport_issued_by varchar(255),
    passport_issued_at date,
    created_at timestamptz default now()
);

insert into user_profiles (user_id, passport_number, passport_issued_by, passport_issued_at)
values (
        'c3f8f280-bd62-4dc8-aaa5-ac6a6f8011f3',
        '770-456-433',
        'ГУ ПО Г. МОСКВЕ район Зябликово',
        to_date('2025-09-10', 'YYYY-MM-DD')
       );

select u.first_name || ' ' || u.last_name as full_name,
       up.passport_number
from users u join public.user_profiles up on u.id = up.user_id;


-- 1 to Many

select u.first_name || ' ' || u.last_name as customer,
       count(o.id) as total_orders,
       sum(o.total_amount) as total_sum
from users u left join public.orders o on u.id = o.user_id
group by u.id, customer;

-- many to many

select
    p.name as product_name,
    count(distinct oi.order_id) as times_ordered,
    sum(oi.quantity) as total_quantity_sold
from products p join public.order_items oi on p.id = oi.product_id
join public.orders o on o.id = oi.order_id
group by p.name;