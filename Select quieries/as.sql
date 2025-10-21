-- as

select column_name as alias_name from tablename;


select name as product_name, price as product_price from products;

select name, price, (price * 0.9) as discount_price from products;