CREATE OR REPLACE FUNCTION generate_marketplace_products(count INTEGER)
RETURNS VOID AS $$
DECLARE
    -- Данные для разных категорий
    tech_brands TEXT[] := ARRAY['Samsung', 'Apple', 'Xiaomi', 'Huawei', 'Sony', 'LG', 'Google', 'OnePlus'];
    clothing_brands TEXT[] := ARRAY['Zara', 'H&M', 'Nike', 'Adidas', 'Reebok', 'Puma', 'Columbia', 'The North Face'];
    furniture_brands TEXT[] := ARRAY['IKEA', 'Hoff', 'Ashley', 'Williams', 'Woodville'];
    beauty_brands TEXT[] := ARRAY['Loreal', 'Maybelline', 'NYX', 'Estee Lauder', 'Clinique', 'Nivea', 'Garnier'];
    food_brands TEXT[] := ARRAY['Nestle', 'Danone', 'JH', 'BABAEV', 'Borj', 'Wert', 'RotFront'];
    toy_brands TEXT[] := ARRAY['Lego', 'Hasbro', 'Mattel', 'Fisher-Price', 'Ravensburger'];

    -- Массивы продуктов по категориям
    tech_items TEXT[] := ARRAY['Smartphone', 'Laptop', 'Tablet', 'Headphones', 'Watch', 'Monitor', 'Photo Camera'];
    clothing_items TEXT[] := ARRAY['Футболка', 'Джинсы', 'Платье', 'Рубашка', 'Куртка', 'Свитер', 'Юбка', 'Шорты'];
    furniture_items TEXT[] := ARRAY['Диван', 'Кресло', 'Стол', 'Стул', 'Шкаф', 'Тумба', 'Полка', 'Кровать'];
    beauty_items TEXT[] := ARRAY['Крем', 'Шампунь', 'Тушь', 'Помада', 'Тональник', 'Тени', 'Лак для волос'];
    food_items TEXT[] := ARRAY['Молоко', 'Сыр', 'Йогурт', 'Сок', 'Печенье', 'Шоколад', 'Макароны', 'Рис'];
    toy_items TEXT[] := ARRAY['Конструктор', 'Кукла', 'Машинка', 'Пазл', 'Мягкая игрушка', 'Настольная игра'];

    colors TEXT[] := ARRAY['Черный', 'Белый', 'Синий', 'Красный', 'Зеленый', 'Желтый', 'Фиолетовый', 'Розовый'];
    sizes TEXT[] := ARRAY['XS', 'S', 'M', 'L', 'XL', 'XXL'];
    materials TEXT[] := ARRAY['Хлопок', 'Полиэстер', 'Шерсть', 'Лен', 'Кожа', 'Дерево', 'Металл', 'Стекло'];

    i INTEGER;
    category_rec RECORD;
    selected_category_id INTEGER;
    selected_category_name TEXT;
    selected_brand TEXT;
    selected_item TEXT;
    selected_color TEXT;
    selected_size TEXT;
    selected_material TEXT;
    product_name TEXT;
    sku TEXT;
    price NUMERIC(10,2);
    discount_price NUMERIC(10,2);
    weight NUMERIC(8,3);
    description TEXT;
BEGIN
    FOR i IN 1..count LOOP
        -- Выбираем случайную ПОДкатегорию (не основную)
        SELECT id, name INTO category_rec
        FROM categories
        WHERE parent_category_id IS NOT NULL
        ORDER BY random()
        LIMIT 1;

        selected_category_id := category_rec.id;
        selected_category_name := category_rec.name;

        -- Определяем тип категории по ИМЕНИ и выбираем соответствующие данные
        CASE
            -- ЭЛЕКТРОНИКА
            WHEN selected_category_name IN ('Смартфоны', 'Планшеты', 'Ноутбуки', 'Телевизоры', 'Наушники', 'Умные часы', 'Фототехника') THEN
                selected_brand := tech_brands[floor(random() * array_length(tech_brands, 1)) + 1];
                selected_item := tech_items[floor(random() * array_length(tech_items, 1)) + 1];
                selected_color := colors[floor(random() * array_length(colors, 1)) + 1];
                price := (random() * 150000 + 5000)::NUMERIC(10,2);
                weight := (random() * 3 + 0.1)::NUMERIC(8,3);

            -- ОДЕЖДА И ОБУВЬ
            WHEN selected_category_name IN ('Мужская одежда', 'Женская одежда', 'Детская одежда', 'Мужская обувь', 'Женская обувь', 'Аксессуары', 'Спортивная одежда') THEN
                selected_brand := clothing_brands[floor(random() * array_length(clothing_brands, 1)) + 1];
                selected_item := clothing_items[floor(random() * array_length(clothing_items, 1)) + 1];
                selected_color := colors[floor(random() * array_length(colors, 1)) + 1];
                selected_size := sizes[floor(random() * array_length(sizes, 1)) + 1];
                selected_material := materials[floor(random() * array_length(materials, 1)) + 1];
                price := (random() * 8000 + 500)::NUMERIC(10,2);
                weight := (random() * 2 + 0.1)::NUMERIC(8,3);

            -- ДОМ И САД
            WHEN selected_category_name IN ('Мебель', 'Текстиль', 'Декор', 'Посуда', 'Кухонная техника', 'Освещение', 'Садовый инвентарь') THEN
                selected_brand := furniture_brands[floor(random() * array_length(furniture_brands, 1)) + 1];
                selected_item := furniture_items[floor(random() * array_length(furniture_items, 1)) + 1];
                selected_color := colors[floor(random() * array_length(colors, 1)) + 1];
                selected_material := materials[floor(random() * array_length(materials, 1)) + 1];
                price := (random() * 30000 + 1000)::NUMERIC(10,2);
                weight := (random() * 25 + 1)::NUMERIC(8,3);

            -- КРАСОТА И ЗДОРОВЬЕ
            WHEN selected_category_name IN ('Косметика', 'Уход за кожей', 'Парфюмерия', 'Уход за волосами', 'Витамины', 'Гигиена') THEN
                selected_brand := beauty_brands[floor(random() * array_length(beauty_brands, 1)) + 1];
                selected_item := beauty_items[floor(random() * array_length(beauty_items, 1)) + 1];
                price := (random() * 3000 + 100)::NUMERIC(10,2);
                weight := (random() * 0.8 + 0.05)::NUMERIC(8,3);

            -- ПРОДУКТЫ ПИТАНИЯ
            WHEN selected_category_name IN ('Бакалея', 'Молочные продукты', 'Мясо и птица', 'Овощи и фрукты', 'Напитки', 'Сладости', 'Замороженные продукты') THEN
                selected_brand := food_brands[floor(random() * array_length(food_brands, 1)) + 1];
                selected_item := food_items[floor(random() * array_length(food_items, 1)) + 1];
                price := (random() * 800 + 50)::NUMERIC(10,2);
                weight := (random() * 3 + 0.1)::NUMERIC(8,3);

            -- ДЕТСКИЕ ТОВАРЫ
            WHEN selected_category_name IN ('Игрушки', 'Одежда для новорожденных', 'Коляски', 'Товары для школы', 'Развивающие игры', 'Детское питание') THEN
                selected_brand := toy_brands[floor(random() * array_length(toy_brands, 1)) + 1];
                selected_item := toy_items[floor(random() * array_length(toy_items, 1)) + 1];
                selected_color := colors[floor(random() * array_length(colors, 1)) + 1];
                price := (random() * 5000 + 200)::NUMERIC(10,2);
                weight := (random() * 5 + 0.1)::NUMERIC(8,3);

            -- ОСТАЛЬНЫЕ КАТЕГОРИИ (по умолчанию)
            ELSE
                selected_brand := 'Brand-' || (floor(random() * 100) + 1)::TEXT;
                selected_item := 'Товар-' || (floor(random() * 100) + 1)::TEXT;
                price := (random() * 10000 + 500)::NUMERIC(10,2);
                weight := (random() * 10 + 0.1)::NUMERIC(8,3);
        END CASE;

        -- Формируем название товара
        product_name := selected_brand || ' ' || selected_item;

        -- Добавляем характеристики если есть
        IF selected_color IS NOT NULL THEN
            product_name := product_name || ' ' || selected_color;
        END IF;

        IF selected_size IS NOT NULL THEN
            product_name := product_name || ' ' || selected_size;
        END IF;

        -- Генерируем SKU
        sku := upper(substring(selected_brand from 1 for 3)) || '-' ||
               lpad((floor(random() * 10000))::TEXT, 3, '0') || '-' ||
               lpad((floor(random() * 10000))::TEXT, 4, '0');

        -- Скидка только для 25% товаров
        IF random() < 0.25 THEN
            discount_price := (price * (0.7 + random() * 0.25))::NUMERIC(10,2); -- Скидка 5-30%
        ELSE
            discount_price := NULL;
        END IF;

        -- Формируем описание
        description := lower(selected_item) || ' от бренда ' || selected_brand ||
                      ' в категории ' || selected_category_name || '. ';

        IF selected_color IS NOT NULL THEN
            description := description || 'Цвет: ' || selected_color || '. ';
        END IF;

        IF selected_size IS NOT NULL THEN
            description := description || 'Размер: ' || selected_size || '. ';
        END IF;

        IF selected_material IS NOT NULL THEN
            description := description || 'Материал: ' || selected_material || '. ';
        END IF;

        description := description || 'Гарантия качества. Быстрая доставка.';

        -- Вставляем товар
        INSERT INTO products (
            category_id, sku, name, description, price, discount_price,
            stock_quantity, weight_kg, is_active, is_featured
        ) VALUES (
            selected_category_id,
            sku,
            product_name,
            description,
            price,
            discount_price,
            floor(random() * 100)::INTEGER,
            weight,
            random() > 0.05,
            random() < 0.15
        );

    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT generate_marketplace_products(200);
