
EXPLAIN [ (option [, ...])] statement;

explain select * from users where email = 'test@mail.ru';

explain (ANALYZE, BUFFERS, SETTINGS )
select * from orders where total_amount > 1000;

-- analyze - execute query and show real stat
-- verbose - детальная информация о столбцах
-- costs - стоимость операции
-- buffers - из кеша
-- timing - детальное время операции
-- summary - итоговая стата
-- format - формат вывода в текст, json, yaml, xml
-- settings - настройки бд

-- seq scan - последовательное чтение
-- index scan - чтение по индексу
-- hash join - соединение через хеш таблицу
-- nested loop - вложенные циклы
-- cost - стоимость оценки
-- actual time - время выполнения