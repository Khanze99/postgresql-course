-- конкатенация

select 'Hello ' || 'World!' as greeting;

select users.first_name || ' ' || users.last_name as fullname from users;

select 'Цена: ' || price || ' руб.' as price_info from products;