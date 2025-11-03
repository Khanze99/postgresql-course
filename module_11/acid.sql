-- ACID

-- A (Atomicity) - атомарность

create table bank_accounts (
    id serial primary key,
    user_id uuid,
    balance numeric(10, 2)
);

begin;
update bank_accounts set balance = balance - 100 where id = 1;
update bank_accounts set balance = balance + 100 where id = 2;
commit;


-- C (Consistency) - Согласованность

begin;
insert into bank_accounts(user_id, balance) values ('uuid', 1000);
commit;


-- I (isolation) - изоляция

begin;
select * from bank_accounts where id = 1;
commit ;


-- D (Durability) - долговечность или надежность



BEGIN;
-- sql operations
COMMIT;
-- or
ROLLBACK;