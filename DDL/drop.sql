-- drop columns

alter table tablename drop column column_name;

alter table tablename drop column if exists column_name;

alter table tablename drop column column_name cascade;

-- drop tables

drop table tablename;

drop table if exists tablename;

drop table tablename cascade;

truncate tablename;

-- drop constrains

alter table tablename drop constraint constrain_name;

alter table tablename drop constraint if exists constraint_name;


-- Рекомендации:
-- Удаленные объекты невозможно восстановить, используйте бэкап
-- Используйте CASCADE осторожно, проверяйте зависимости через /d tablename
-- DROP TABLE блокирует всю таблицу, планируйте операцию на время низкой нагрузки
