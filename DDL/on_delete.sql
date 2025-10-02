-- RESTRICT

create table orders (
    id serial primary key,
    user_id int references users(id) on delete restrict
);


-- CASCADE

create table orders (
    id serial primary key,
    user_id int references users(id) on delete cascade
);

drop table users;

delete from users where id = 1;

-- SET NULL
create table orders (
    id serial primary key,
    user_id int references users(id) on delete set null
);

-- DEFAULT

create table orders (
    id serial primary key,
    user_id int references users(id) on delete set default default 2
);


-- NO ACTION

create table orders
(
    id      serial primary key,
    user_id int references users (id) on delete no action
);

BEGIN;
-- action
delete from users where id = 1;
-- action
COMMIT
