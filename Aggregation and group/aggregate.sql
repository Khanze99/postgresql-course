-- aggregate

select
    count(*) as total_users,
    count(users.date_of_birth) as user_with_birthdate,
    count(distinct extract(year from users.date_of_birth)) as unique_birth_years,
    min(users.created_at) as first_registration,
    max(users.created_at) as last_registration,
    avg(extract(year from age(users.date_of_birth))) as avg_age
from users;