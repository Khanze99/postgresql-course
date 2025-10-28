-- sets union, intersect, except

-- union, union all

select
    id,
    first_name || ' ' || last_name as fullname,
    'Active user' as type
from users
where is_active is true

union

select
    u.id,
    u.first_name || ' ' || u.last_name as name,
    'Has orders' as type
from users u
join orders o on u.id = o.user_id;

select
    'Order status: ' || status as metric,
    count(*)
from orders
group by status

union all

select
    'Payment status: ' || payment_status,
    count(*)
from payments
group by payment_status;

-- intersect

select id from users where is_email_verified is true

intersect

select distinct user_id from orders;


-- except

select id from users where is_email_verified is true

except

select distinct user_id from orders;

