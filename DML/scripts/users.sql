CREATE OR REPLACE FUNCTION generate_users(count INTEGER)
RETURNS VOID AS $$
DECLARE
    first_names_male TEXT[] := ARRAY['James', 'John', 'Robert', 'Michael', 'William', 'David', 'Richard', 'Joseph', 'Thomas', 'Charles'];
    first_names_female TEXT[] := ARRAY['Mary', 'Patricia', 'Jennifer', 'Linda', 'Elizabeth', 'Barbara', 'Susan', 'Jessica', 'Sarah', 'Karen'];

    last_names TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson'];

    domains TEXT[] := ARRAY['gmail.com', 'yahoo.com', 'outlook.com', 'icloud.com', 'hotmail.com'];
    phone_codes TEXT[] := ARRAY['901', '902', '903', '904', '905', '906', '915', '916', '917', '919'];

    i INTEGER;
    gender TEXT;
    first_name TEXT;
    last_name TEXT;
    email TEXT;
    phone TEXT;
    email_local_part TEXT;
    date_of_birth DATE;
    password_hash TEXT;
BEGIN
    FOR i IN 1..count LOOP
        -- Определяем пол (50/50)
        IF random() < 0.5 THEN
            gender := 'male';
            first_name := first_names_male[floor(random() * array_length(first_names_male, 1)) + 1];
        ELSE
            gender := 'female';
            first_name := first_names_female[floor(random() * array_length(first_names_female, 1)) + 1];
        END IF;

        last_name := last_names[floor(random() * array_length(last_names, 1)) + 1];

        -- Генерируем email в разных форматах
        CASE
            WHEN random() < 0.3 THEN
                email_local_part := lower(first_name) || '.' || lower(last_name);
            WHEN random() < 0.6 THEN
                email_local_part := lower(substring(first_name from 1 for 1)) || lower(last_name);
            ELSE
                email_local_part := lower(first_name) || floor(random() * 1000)::TEXT;
        END CASE;

        email := email_local_part || '@' || domains[floor(random() * array_length(domains, 1)) + 1];

        -- Генерируем телефон (российский формат)
        phone := '+7' || phone_codes[floor(random() * array_length(phone_codes, 1)) + 1] ||
                lpad(floor(random() * 10000000)::TEXT, 7, '0');

        -- Генерируем дату рождения (от 18 до 80 лет)
        date_of_birth := CURRENT_DATE - (floor(random() * (80 - 18) + 18) * 365 + floor(random() * 365))::INTEGER;

        -- Генерируем хеш пароля (фиктивный, но валидный формат bcrypt)
        password_hash := '$2a$12$' || substring(md5(random()::TEXT) from 1 for 22) || '.' || substring(md5(random()::TEXT) from 1 for 31);

        -- Вставляем пользователя
        INSERT INTO users (
            email, password_hash, first_name, last_name, phone,
            date_of_birth, is_active, is_email_verified
        ) VALUES (
            email,
            password_hash,
            first_name,
            last_name,
            phone,
            date_of_birth,
            random() > 0.05, -- 95% активны
            random() > 0.3   -- 70% подтвердили email
        );

    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Генерируем 50 пользователей
SELECT generate_users(50);
