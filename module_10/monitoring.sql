
-- Текущие активные запросы
SELECT
    pid,
    usename,
    application_name,
    query,
    state,
    now() - query_start as duration
FROM pg_stat_activity
WHERE state = 'active'
  AND query NOT LIKE '%pg_stat_activity%'
ORDER BY duration DESC;

-- Статистика по таблицам
SELECT
    schemaname,
    relname,
    seq_scan as sequential_scans,
    seq_tup_read as tuples_read_seq,
    idx_scan as index_scans,
    idx_tup_fetch as tuples_fetched_idx,
    n_tup_ins as inserts,
    n_tup_upd as updates,
    n_tup_del as deletes,
    n_live_tup as live_tuples,
    n_dead_tup as dead_tuples
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY seq_scan DESC;


-- Эффективность индексов
SELECT
    schemaname,
    relname,
    indexrelname,
    idx_scan as index_scans,
    idx_tup_read as tuples_read,
    idx_tup_fetch as tuples_fetched
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;


-- Неиспользуемые индексы (кандидаты на удаление)
SELECT
    schemaname,
    relname,
    indexrelname,
    idx_scan as index_scans
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY relname, indexrelname;


-- Размеры индексов
SELECT
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexname::regclass)) as index_size
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY pg_relation_size(indexname::regclass) DESC;


-- Текущие блокировки
SELECT
    blocked_locks.pid AS blocked_pid,
    blocked_activity.usename AS blocked_user,
    blocking_locks.pid AS blocking_pid,
    blocking_activity.usename AS blocking_user,
    blocked_activity.query AS blocked_statement,
    blocking_activity.query AS blocking_statement
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
JOIN pg_catalog.pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
    AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
    AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
    AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
    AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
    AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
    AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
    AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
    AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
    AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
    AND blocking_locks.pid != blocked_locks.pid
JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.GRANTED;


-- Общий размер БД
SELECT
    datname,
    pg_size_pretty(pg_database_size(datname)) as size
FROM pg_database
WHERE datname = current_database();


-- Долгие транзакции (> 10 минут)
SELECT
    pid,
    now() - xact_start as duration,
    query
FROM pg_stat_activity
WHERE state = 'active'
  AND now() - xact_start > interval '10 minutes';



-- Высокое количество мертвых кортежей (> 20%)
SELECT
    schemaname,
    relname,
    n_live_tup as live_tuples,
    n_dead_tup as dead_tuples,
    round(n_dead_tup::numeric / (n_live_tup + n_dead_tup) * 100, 2) as dead_percent
FROM pg_stat_user_tables
WHERE n_live_tup + n_dead_tup > 1000
  AND n_dead_tup::numeric / (n_live_tup + n_dead_tup) > 0.2
ORDER BY dead_percent DESC;

vacuum tablename;