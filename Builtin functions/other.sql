-- coalesce, case, cast

coalesce(v1,v2,v3,..., default_v);

select
    users.first_name,
    users.last_name,
    users.date_of_birth,
    coalesce(users.date_of_birth, '2000-01-01'::date) as safe_date
from users where id = '51756a51-9104-43e9-b34b-3ea37740785a';


-- case

case expression
    when v1 then r1
    when v2 then r2
    else default
end;

select
    users.first_name,
    users.last_name,
    users.date_of_birth,
    case
        when extract(year from age(users.date_of_birth)) < 18 then 'Подросток'
        when extract(year from age(users.date_of_birth)) between 18 and 25 then 'Молодежь'
        else 'И другие'
    end as age_group
from users;


-- cast or ::

expression::type;
cast(expression as type);

select
    users.first_name,
    users.last_name,
    users.created_at,
    users.created_at::text as created_at_text,
    users.created_at::date as cerated_at_date,
    users.created_at::time as time_only
from users;
