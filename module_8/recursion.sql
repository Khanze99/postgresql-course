-- CTE - Common table expression (Обобщенная таблица)

WITH RECURSIVE name_cte AS (
    -- 1. anchor (начальный) запрос
    SELECT ...
    FROM table1
    WHERE ...

    UNION ALL | UNION

    -- 2. Рекурсивная часть
    SELECT ...
    FROM table1
    JOIN name_cte ON ...
)

-- 3. Финальный SELECT
SELECT ...
FROM name_cte;


with recursive nums as (
    select 1 as n
    union all
    select n + 1 as n from nums where n < 100
)

select sum(n) from nums;


with recursive category_hierarchy as (
    select
        id,
        name,
        0 as level,
        name::varchar(200) as full_path
    from categories
    where parent_category_id is null

    union all

    select
        c.id,
        c.name,
        ch.level + 1 as level,
        (ch.full_path || ' -> ' || c.name)::varchar(200) as full_path
    from categories as c
    join category_hierarchy as ch on c.parent_category_id = ch.id
)

select id, name, level, full_path from category_hierarchy;