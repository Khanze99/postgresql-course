explain (analyze, buffers)
select * from users
where first_name like '%Иван%' or email like '%ivan%'
order by created_at desc;

create extension if not exists pg_tgrm;

create index concurrently idx_users_first_name_tgrm on users using gin(first_name gin_trgm_ops);
create index concurrently idx_users_first_email_tgrm on users using gin(email gin_trgm_ops);


explain (analyze, buffers)
select * from users
where first_name ilike '%иван%' or email ilike '%ivan%'
order by created_at desc;


-- where, join, order by, group by


