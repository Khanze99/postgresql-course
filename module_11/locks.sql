-- locks

-- raw-level locks

-- for update
create table bank_accounts (
    id serial primary key,
    user_id uuid,
    balance numeric(10, 2)
);

select * from bank_accounts where id = 1 for update;

-- locks read

select * from bank_accounts where id = 1 for share;


-- NOWAIT

begin;
select *
from bank_accounts where id = 1 for update nowait;  -- error


-- ddl alter table, drop table

lock table bank_accounts;


-- session 1 - t1
begin;
update bank_accounts set balance = balance - 100 where id = 1;  -- lock a-1
-- from t2
update bank_accounts set balance = balance + 100 where id = 2; -- wait b-2



-- session 2 - t2
begin;
update bank_accounts set balance = balance - 200 where id = 2;  -- lock b-2
-- to t1
update bank_accounts set balance = balance + 200 where id = 1;  -- wait t1
-- DEADLOCK!
-- psql can resolve


-- monitoring locks
SELECT * FROM pg_locks WHERE granted = false;  -- Ожидающие блокировки

-- Долгие ожидания
SELECT now() - query_start as waiting_time, query
FROM pg_stat_activity
WHERE wait_event_type = 'Lock';

SELECT now() - query_start as waiting_time, query
FROM pg_stat_activity;