-- age, extract

select
    users.first_name,
    users.date_of_birth,
    age(users.date_of_birth) as age_interval,
    extract(year from age(users.date_of_birth)) as age_years,
    extract(month from age(users.date_of_birth)) as age_month
from users;

-- date_trunc - обрезка

select
    users.created_at,
    date_trunc('year', users.created_at) as year_start,
    date_trunc('month', users.created_at) as month_start,
    date_trunc('week', users.created_at) as week_start,
    date_trunc('day', users.created_at) as day_start
from users;


-- justify_interval - нормализация интервалов

select
    interval '30 days' as raw_interval,
    justify_interval(interval '30 days') as normal;


-- to date and to timestamp

select
    to_date('20231225', 'YYYYMMDD') as date1,
    to_date('25-12-2023', 'DD-MM-YYYY') as date2,
    to_date('December 25, 2023', 'Month DD, YYYY') as date3;


select
    to_timestamp('20231225 143025', 'YYYYMMDD HH24MISS') as timestamp1,
    to_timestamp('25-12-2023 14:30:25', 'DD-MM-YYYY HH24:MI:SS') as timestamp2;


