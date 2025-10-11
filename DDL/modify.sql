-- add columns

create table logs (
    id serial primary key,
    message text
);

alter table tablename add column columnname datatype;

alter table logs add column error text;


-- delete columns

alter table tablename drop column column_name;

alter table tablename drop column column_name cascade;

alter table tablename drop column if exists column_name;

-- change type data

alter table tablename alter column column_name TYPE new_data_type;

alter table tablename alter column column_name type new_date_type using expression;

alter table users alter column age type smallint;

alter table users alter column signup_date type DATE using signup_date::DATE;


-- change constraints

alter table tablename alter column column_name set not null;

alter table tablename alter column column_name drop not null;

alter table tablename add check ( condition );

alter table tablename drop constraint constraint_name;

alter table users alter column email set not null;

alter table users add constraint ck_age check ( age > 14 );

-- rename

alter table old_table_name rename to new_table_name;

alter table tablename rename column old_column to new_column;

alter table users rename to users_data;
alter table users rename column first_name to name;

alter table tablename rename constraint old_name to new_name;


-- change default

alter table tablename alter column column_name set default default_value;

alter table tablename alter column column_name drop default;

alter table users alter column created_at set default now();

alter table users alter column status set default 'active';


create table test (
    id int
);

alter table test add constraint pk_id primary key (id);
alter table test add column user_name varchar(20);
alter table test rename column user_name to name;
alter table test alter column name set not null;

alter table test add column status varchar(10);

alter table test add constraint ck_status check ( status in ('active', 'inactive', 'fired', 'banned') );
alter table test drop column status;
