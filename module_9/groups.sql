
select
    email,
    total_spent,
    ntile(3) over (order by total_spent desc) as spending_group
from (
    select u.email, coalesce(sum(o.total_amount), 0) as total_spent
    from users u left join public.orders o on u.id = o.user_id
    group by u.id, u.email
     ) user_stats;