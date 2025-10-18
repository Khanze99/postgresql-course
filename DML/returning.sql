

-- returning


-- insert

insert into products (category_id, sku, name, description, price) values (1, 'TEST-12', 'test', 'test-desc', 100.99);
select * from products where name = 'test';

insert into products (category_id, sku, name, description, price) values (1, 'TEST-13', 'test2', 'test2-desc', 100.99)
returning *;


-- update
update tablename set column1 = value1 where condition returning id, colimn1, column2;


select * from products where category_id = 1;
update products set price = price * 1.1 where category_id = 1 returning id, name, price;

-- delete

delete from tablenae where condition returning *;

delete from orders where status = 'shipped' returning order_number, total_amount;
