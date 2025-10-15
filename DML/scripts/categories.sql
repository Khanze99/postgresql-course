truncate categories cascade;

INSERT INTO categories (name, description, sort_order) VALUES
('Электроника', 'Техника и электронные устройства', 1),
('Одежда и обувь', 'Одежда, обувь и аксессуары', 2),
('Дом и сад', 'Товары для дома, мебель, декор', 3),
('Красота и здоровье', 'Косметика, уход, витамины', 4),
('Продукты питания', 'Продукты, напитки, бакалея', 5),
('Детские товары', 'Товары для детей и игрушки', 6),
('Спорт и отдых', 'Спортивные товары, туризм', 7),
('Автотовары', 'Автозапчасти и аксессуары', 8),
('Книги и канцелярия', 'Книги, учебники, канцтовары', 9),
('Зоотовары', 'Товары для домашних животных', 10);

-- Подкатегории для Электроника
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Электроника'),
    sort_order
FROM (VALUES
    ('Смартфоны', 'Мобильные телефоны', 1),
    ('Планшеты', 'Планшетные компьютеры', 2),
    ('Ноутбуки', 'Портативные компьютеры', 3),
    ('Телевизоры', 'Телевизоры и мониторы', 4),
    ('Наушники', 'Беспроводные и проводные наушники', 5),
    ('Умные часы', 'Смарт-часы и фитнес-браслеты', 6),
    ('Фототехника', 'Фотоаппараты и объективы', 7)
) AS elec(name, description, sort_order);

-- Подкатегории для Одежда и обувь
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Одежда и обувь'),
    sort_order
FROM (VALUES
    ('Мужская одежда', 'Одежда для мужчин', 1),
    ('Женская одежда', 'Одежда для женщин', 2),
    ('Детская одежда', 'Одежда для детей', 3),
    ('Мужская обувь', 'Обувь для мужчин', 4),
    ('Женская обувь', 'Обувь для женщин', 5),
    ('Аксессуары', 'Сумки, ремни, головные уборы', 6),
    ('Спортивная одежда', 'Одежда для спорта', 7)
) AS cloth(name, description, sort_order);

-- Подкатегории для Дом и сад
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Дом и сад'),
    sort_order
FROM (VALUES
    ('Мебель', 'Мебель для дома и офиса', 1),
    ('Текстиль', 'Постельное белье, шторы, полотенца', 2),
    ('Декор', 'Предметы интерьера, картины, вазы', 3),
    ('Посуда', 'Кухонная посуда и столовые приборы', 4),
    ('Кухонная техника', 'Бытовая техника для кухни', 5),
    ('Освещение', 'Лампы, светильники, бра', 6),
    ('Садовый инвентарь', 'Инструменты для сада', 7)
) AS home(name, description, sort_order);

-- Подкатегории для Красота и здоровье
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Красота и здоровье'),
    sort_order
FROM (VALUES
    ('Косметика', 'Декоративная косметика', 1),
    ('Уход за кожей', 'Кремы, сыворотки, тоники', 2),
    ('Парфюмерия', 'Духи, туалетная вода', 3),
    ('Уход за волосами', 'Шампуни, бальзамы, стайлинг', 4),
    ('Витамины', 'БАДы, витаминные комплексы', 5),
    ('Гигиена', 'Средства личной гигиены', 6)
) AS beauty(name, description, sort_order);

-- Подкатегории для Продукты питания
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Продукты питания'),
    sort_order
FROM (VALUES
    ('Бакалея', 'Крупы, макароны, специи', 1),
    ('Молочные продукты', 'Молоко, сыр, йогурты', 2),
    ('Мясо и птица', 'Мясные продукты', 3),
    ('Овощи и фрукты', 'Свежие овощи и фрукты', 4),
    ('Напитки', 'Соки, вода, газировка', 5),
    ('Сладости', 'Конфеты, шоколад, печенье', 6),
    ('Замороженные продукты', 'Замороженные овощи и полуфабрикаты', 7)
) AS food(name, description, sort_order);

-- Подкатегории для Детские товары
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Детские товары'),
    sort_order
FROM (VALUES
    ('Игрушки', 'Детские игрушки', 1),
    ('Одежда для новорожденных', 'Одежда для малышей', 2),
    ('Коляски', 'Детские коляски', 3),
    ('Товары для школы', 'Ранцы, пеналы', 4),
    ('Развивающие игры', 'Обучающие игры', 5),
    ('Детское питание', 'Питание для детей', 6)
) AS kids(name, description, sort_order);

-- Подкатегории для Спорт и отдых
INSERT INTO categories (name, description, parent_category_id, sort_order)
SELECT
    name, description,
    (SELECT id FROM categories WHERE name = 'Спорт и отдых'),
    sort_order
FROM (VALUES
    ('Фитнес', 'Фитнес оборудование', 1),
    ('Велоспорт', 'Велосипеды и аксессуары', 2),
    ('Туризм', 'Туристическое снаряжение', 3),
    ('Зимние виды спорта', 'Лыжи, сноуборды', 4),
    ('Игры с мячом', 'Футбол, баскетбол, теннис', 5)
) AS sport(name, description, sort_order);