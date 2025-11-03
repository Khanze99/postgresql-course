-- b-tree
-- hash - точные совпадения
-- gist - geo/полнотекстовый поиск
-- gin - полнотекстовый поиск/jsonb/arrays
-- sp-gist - неоднородные данные
-- brin - большие хронологические данные
-- bloom - многоколоночная фильтрация
-- rum - расширенный полтекстовый поиск

-- b-tree

create index idx_users_email on users(email);

create unique index idx_users_phone_unique on users(phone);

create index idx_orders_user_data on orders(user_id, created_at);

create index idx_products_active on products(name) where is_active = true;

create index idx_orders_created_at_desc on orders(created_at desc );


-- hash

create index idx_users_email_hash on users using hash(email);

-- gist

alter table products add column search_vector tsvector;
update products set search_vector = to_tsvector('russian', name || ' ' || coalesce(description, ''));

create index idx_products_search_gist on products using gist(search_vector);


-- gin

create index idx_products_search_gin on products using gin(search_vector);