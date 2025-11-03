-- sequence

create sequence order_number_seq
    start with 1000
    increment by 1
    minvalue 1000
    maxvalue 9999999
    cache 10;


create sequence order_number_seq start with 1000 increment by 1;

create table orders (
    id serial primary key,
    order_number varchar(20) default 'ORD-' || nextval('order_number_seq')
);


select nextval('order_number_seq');

select currval('order_number_seq');

select lastval('order_number_seq');

select setval('order_number_seq', 1500);

-- serial
create sequence custom_id_seq start with 1 increment by 1;

create table products(
    id integer primary key default nextval('custom_id_seq')
)