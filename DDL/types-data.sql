-- int
-- serial
-- numeral/decimal
-- float

create table store (
    id serial primary key,
    quantity int not null,
    price numeric(12, 2) not null,
    area float not null
);

-- char(n)
-- varchar(n)
-- text
-- json/jsonb


-- bool
drop table users;
create table users (
    first_name varchar(100),
    bio text,
    characteristic json,
    is_deleted boolean default false
);

-- date
-- TIME
-- TIMESTAMP
-- TIMESTAMP WITH TIME ZONE
-- interval

create table schedule (
    id serial primary key,
    name varchar(100),
    day_date date,
    start_time time,
    end_time time
);

create table logs (
    id serial primary key,
    message text,
    created_at timestamp default current_timestamp
);


create table events (
    id serial primary key,
    name varchar(100),
    event_time timestamptz,
    duration interval
);


-- UUID
-- сетевые: inet, cidr, macaddr
-- геометрические: point, line, polygon, circle
-- служебные: tsvecctor/tsquery, xml

create table users (
    id uuid
);
