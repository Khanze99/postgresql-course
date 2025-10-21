
-- structure
SELECT -- то что выбираем
    [DISTINCT | ALL]
    column_list
    [INTO new_table]  -- создание таблицы из результатов выьорки
    FROM table_sources -- откуда выбираем
    [WHERE search_condition] -- условия выборки
    [GROUP BY group_by_expression] -- группировка (полноценно разберем в следующих модулях)
    [HAVING search_condition] -- условия выборки при группировки
    [ORDER BY order_expression [ASC | DESC]] -- сортировка
    [LIMIT number] -- ограничения
    [OFFSET number];

-- example

select users.first_name, users.last_name, users.email, is_email_verified, date(users.created_at) as registration_date
from users
where is_email_verified is true and created_at >= '2024-01-01'
order by registration_date desc
limit 50;