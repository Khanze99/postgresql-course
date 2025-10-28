-- rank, dense_rank

select
    products.name,
    products.category_id,
    products.price,
    rank() over (partition by products.category_id order by products.price desc) as rank,
    dense_rank() over (partition by products.category_id order by products.price desc) as dense_rank
from products
where is_active is true;
