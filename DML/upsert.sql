

-- upsert structure
insert into tablename (column1, column2) values (value1, value2) on conflict (column_conflict) do update
set column1 = excluded.column1, column2 = excluded.column2;

--excluded

-- nothing

insert into tablename (column1, column2) values (value1, value2) on conflict do nothing;

-- example

insert into products (sku, name, price, stock_quantity, category_id) values ('IPHONE-15', 'Iphone 15', 999.99, 50, 11)
on conflict (sku)
do update set
              price = excluded.price,
              stock_quantity = excluded.stock_quantity + products.stock_quantity,
              updated_at = NOW();

-- example nothing

insert into orders (user_id, order_number, total_amount, status, shipping_address_id)
values ('2857463b-e8a3-4cb2-a7a2-4c5b39bcd36f', 'ORD-20251008-0001', 199.99, 'pending', 68)
on conflict (order_number)
do nothing;