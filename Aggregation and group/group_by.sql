-- group by


select
    users.is_active,
    count(*) as user_count,
    avg(extract(year from age(coalesce(users.date_of_birth, '2001-01-01'::date)))) as avg_age
from users
group by is_active;


select
    users.is_active,
    users.is_email_verified,
    count(*) as user_count,
    round(avg(extract(year from age(users.date_of_birth))), 2) as avg_age,
    min(users.created_at) as first_registration
from users
group by is_active, is_email_verified;


-- having

select
    extract(year from users.date_of_birth) as birth_year,
    count(*) as user_count
from users
where date_of_birth is not null
group by extract(year from users.date_of_birth)
having count(*) > 2
order by user_count desc;

