

create or replace function functionname()  -- 1
returns trigger as $$
    begin
        -- logic
        return new;  -- or old
    end;
    $$ language plpgsql;


-- 2 trigger

create trigger trigger_name
    when (before/after) (insert/update/delete)
    on table
    for each row -- for each statement
    execute function functionname();

insert into table() values()


insert into table()
values (1,100), (2, 300);



create or replace function update_updated_at()
returns trigger as $$
    begin
        new.updated_at = now();
        return new;
    end;
    $$ language plpgsql;

create trigger trigger_users_updated_at
    before update on users
    for each row
    execute function update_updated_at();


-- before
-- after
-- for each row
-- for each statement - для оператора

-- new
-- old
-- tg_op (insert etc.)
-- tg_table_name