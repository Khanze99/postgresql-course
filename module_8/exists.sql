

select
    u.first_name,
    u.last_name
from users u
where exists(
    select 1 from orders o where o.user_id = u.id
);


select name
from categories c
where not exists(
    select 1 from products p where p.category_id = c.id
);