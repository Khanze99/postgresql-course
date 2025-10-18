CREATE OR REPLACE FUNCTION generate_user_addresses(count_per_user INTEGER DEFAULT 2)
RETURNS VOID AS $$
DECLARE
    user_rec RECORD;
    address_types TEXT[] := ARRAY['home', 'work', 'other'];
    countries TEXT[] := ARRAY['Russia', 'USA', 'Germany', 'France', 'UK', 'Japan'];

    russian_cities TEXT[] := ARRAY['Moscow', 'Saint Petersburg', 'Novosibirsk', 'Yekaterinburg', 'Kazan', 'Nizhny Novgorod', 'Chelyabinsk', 'Samara'];
    russian_streets TEXT[] := ARRAY['Lenin Street', 'Gorky Street', 'Pushkin Street', 'Soviet Street', 'Peace Street', 'Central Street', 'Youth Street', 'Garden Street'];

    us_cities TEXT[] := ARRAY['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego'];
    us_streets TEXT[] := ARRAY['Main Street', 'Park Avenue', 'Oak Street', 'Maple Avenue', 'Washington Street', 'Broadway', 'First Street', 'Second Street'];

    i INTEGER;
    address_type TEXT;
    country TEXT;
    city TEXT;
    street TEXT;
    postal_code TEXT;
    apartment TEXT;
BEGIN
    FOR user_rec IN SELECT id FROM users LOOP
        -- Для каждого пользователя создаем от 1 до count_per_user адресов
        FOR i IN 1..(floor(random() * count_per_user) + 1) LOOP
            -- Выбираем тип адреса (уникальный для пользователя)
            address_type := address_types[i];
            IF address_type IS NULL THEN
                address_type := 'other';
            END IF;

            -- Выбираем страну (80% Россия, 20% другие)
            IF random() < 0.8 THEN
                country := 'Russia';
                city := russian_cities[floor(random() * array_length(russian_cities, 1)) + 1];
                street := russian_streets[floor(random() * array_length(russian_streets, 1)) + 1];
                postal_code := lpad(floor(random() * 1000000)::TEXT, 6, '0');
            ELSE
                country := countries[floor(random() * (array_length(countries, 1) - 1)) + 2]; -- исключаем Russia
                city := us_cities[floor(random() * array_length(us_cities, 1)) + 1];
                street := us_streets[floor(random() * array_length(us_streets, 1)) + 1];
                postal_code := lpad(floor(random() * 100000)::TEXT, 5, '0');
            END IF;

            -- Генерируем номер квартиры (70% имеют квартиру)
            IF random() < 0.7 THEN
                apartment := (floor(random() * 200) + 1)::TEXT ||
                            CASE WHEN random() < 0.3 THEN '-' || (floor(random() * 10) + 1)::TEXT ELSE '' END;
            ELSE
                apartment := NULL;
            END IF;

            -- Вставляем адрес
            INSERT INTO user_addresses (
                user_id, address_type, country, city, postal_code,
                street, apartment, is_default
            ) VALUES (
                user_rec.id,
                address_type,
                country,
                city,
                postal_code,
                street || ' ' || (floor(random() * 100) + 1)::TEXT, -- добавляем номер дома
                apartment,
                i = 1 -- первый адрес по умолчанию основной
            );

        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Генерируем по 1-2 адреса для каждого пользователя
SELECT generate_user_addresses(2);