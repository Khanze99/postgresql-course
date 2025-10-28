-- all

select name, price
from products
where price > all (
    select price from products
                 where category_id = (select id from categories where name = 'Фитнес')
    );

-- any

select name, price
from products
where price > any (
    select price from products where category_id = (select id from categories where name = 'Аксессуары')
    );