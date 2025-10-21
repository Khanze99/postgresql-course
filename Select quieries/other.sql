-- order by

select name, price from products order by price asc;

-- limit
select name, price from products limit 10;

-- offset

select name, price from products limit 10 offset 10;
