
select name, price, discount_price
from products
where (price, coalesce(discount_price, 0)) in (
    select price, coalesce(discount_price, 0)
    from products
    where name ilike '%iphone%'
    );

select users.first_name, users.last_name, users.email
from users
where (first_name, split_part(email, '@', 2)) in (
    select first_name, split_part(email, '@', 2)
    from users
    group by first_name, split_part(email, '@', 2)
    having count(*) > 1
    );