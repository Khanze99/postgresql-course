
-- upper, lower, initcap

select
    products.name,
    upper(products.name),
    lower(products.name),
    initcap(products.name)
from products;

-- длина и позиция

select
    products.name,
    length(products.name),
    position('Lego' in products.name) as phone_position,
    strpos(products.name, 'Pro') as pro_position
from products;


-- подстроки

select
    products.name,
    substring(products.name from 1 for 5) as first_5_chars,
    left(products.name, 3) as first_3_chars,
    right(products.name, 4) as last_4_chars
from products;


-- обрезка пробелов

select
    '  Hello World  ' as original,
    trim('  Hello World  ') as trimmed,
    ltrim('  Hello World  ') as ltrimmed,
    rtrim('  Hello World  ') as rtrimmed;


-- замена и трансформация

select
    products.name,
    replace(products.name, 'Lego', 'Smartphone') as replaces,
    reverse(products.name) as reversed,
    repeat('*', 5) as stars
from products;

-- format

select
    format('Товар: %s, Цена: %s руб.', products.name, products.price) as product_info
from products;


-- разбиение split

select
    users.email,
    split_part(users.email, '@', 1) as username,
    split_part(users.email, '@', 2) as domain
from users;
