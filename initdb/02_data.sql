-- Тестовые bulk-данные для базы "Аэропорт"

-- 20 аэропортов в разных городах
INSERT INTO airports (name, city, country, code)
SELECT 
  'Аэропорт ' || gs,
  CASE gs
    WHEN 1 THEN 'Москва'
    WHEN 2 THEN 'Санкт-Петербург'
    WHEN 3 THEN 'Новосибирск'
    WHEN 4 THEN 'Екатеринбург'
    WHEN 5 THEN 'Казань'
    WHEN 6 THEN 'Нижний Новгород'
    WHEN 7 THEN 'Челябинск'
    WHEN 8 THEN 'Самара'
    WHEN 9 THEN 'Ростов-на-Дону'
    WHEN 10 THEN 'Уфа'
    WHEN 11 THEN 'Красноярск'
    WHEN 12 THEN 'Воронеж'
    WHEN 13 THEN 'Пермь'
    WHEN 14 THEN 'Волгоград'
    WHEN 15 THEN 'Краснодар'
    WHEN 16 THEN 'Саратов'
    WHEN 17 THEN 'Тюмень'
    WHEN 18 THEN 'Тольятти'
    WHEN 19 THEN 'Ижевск'
    ELSE 'Барнаул'
  END,
  'Россия',
  'C' || lpad(gs::text, 2, '0')
FROM generate_series(1, 20) AS gs;

-- 100 самолетов
INSERT INTO airplanes (model, seats, manufacturer)
SELECT 
  'Модель ' || gs,
  80 + (gs % 200),
  CASE (gs % 3) WHEN 0 THEN 'Airbus' WHEN 1 THEN 'Boeing' ELSE 'Sukhoi' END
FROM generate_series(1, 100) AS gs;

-- 2000 сотрудников (по 100 на аэропорт)
INSERT INTO employees (name, position, airport_id)
SELECT 'Сотрудник ' || gs, 'Сотрудник', ((gs - 1) / 100) + 1
FROM generate_series(1, 2000) AS gs;

-- 1000 рейсов
INSERT INTO flights (flight_number, departure_airport_id, arrival_airport_id, airplane_id, departure_time, arrival_time)
SELECT 
  'FL' || gs,
  (gs % 20) + 1,
  ((gs+1) % 20) + 1,
  (gs % 100) + 1,
  '2024-07-01'::timestamp + (gs || ' hours')::interval,
  '2024-07-01'::timestamp + ((gs+2) || ' hours')::interval
FROM generate_series(1, 1000) AS gs;

-- 10000 пассажиров
INSERT INTO passengers (name, passport_number)
SELECT 'Пассажир ' || gs, (100000000 + gs)::text
FROM generate_series(1, 10000) AS gs;

-- 10000 билетов
INSERT INTO tickets (flight_id, passenger_id, seat, purchase_time)
SELECT 
  (gs % 1000) + 1,
  (gs % 10000) + 1,
  (chr(65 + (gs % 6)) || (1 + (gs % 30)))::text,
  '2024-06-01'::timestamp + (gs || ' minutes')::interval
FROM generate_series(1, 10000) AS gs; 