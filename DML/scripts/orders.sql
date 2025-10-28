CREATE OR REPLACE FUNCTION generate_orders(count INTEGER)
RETURNS VOID AS $$
DECLARE
    user_rec RECORD;
    address_rec RECORD;
    payment_methods TEXT[] := ARRAY['card', 'paypal', 'cash_on_delivery'];
    order_notes TEXT[] := ARRAY[
        'Please call before delivery',
        'Leave at the front door',
        'No call needed, just deliver',
        'Call one hour before delivery',
        'Fragile items, handle with care',
        'Gift wrapping requested',
        'Delivery after 6 PM',
        'Leave with neighbor if not home'
    ];

    i INTEGER;
    order_counter INTEGER := 0;
    order_date TIMESTAMPTZ;
    selected_status TEXT;
    selected_payment TEXT;
    order_note TEXT;
    total_amount NUMERIC(12,2);
BEGIN
    -- Получаем случайных пользователей с адресами
    FOR i IN 1..count loop
        -- Выбираем случайного пользователя с адресом
        SELECT u.* INTO user_rec
        FROM users u
        WHERE EXISTS (
            SELECT 1 FROM user_addresses ua WHERE ua.user_id = u.id
        )
        ORDER BY random()
        LIMIT 1;

        -- Выбираем случайный адрес этого пользователя
        SELECT * INTO address_rec
        FROM user_addresses
        WHERE user_id = user_rec.id  -- используем сохраненный ID
        ORDER BY random()
        LIMIT 1;

        order_counter := order_counter + 1;

        -- Генерируем случайную дату заказа (от 30 дней назад до сейчас)
        order_date := CURRENT_TIMESTAMP - (random() * 30 * 24 * 60 * 60 || ' seconds')::INTERVAL;

        -- Выбираем статус с распределением вероятностей
        selected_status := CASE
            WHEN random() < 0.05 THEN 'cancelled'      -- 5% отмененных
            WHEN random() < 0.1 THEN 'pending'         -- 5% ожидающих
            WHEN random() < 0.2 THEN 'confirmed'       -- 10% подтвержденных
            WHEN random() < 0.4 THEN 'processing'      -- 20% в обработке
            WHEN random() < 0.8 THEN 'shipped'         -- 40% отправленных
            ELSE 'delivered'                           -- 20% доставленных
        END;

        -- Выбираем метод оплаты
        selected_payment := payment_methods[floor(random() * array_length(payment_methods, 1)) + 1];

        -- Генерируем примечание (только для 30% заказов)
        IF random() < 0.3 THEN
            order_note := order_notes[floor(random() * array_length(order_notes, 1)) + 1];
        ELSE
            order_note := NULL;
        END IF;

        -- Генерируем общую сумму (от 500 до 50000 рублей)
        total_amount := (random() * 49500 + 500)::NUMERIC(12,2);

        -- Вставляем заказ
        INSERT INTO orders (
            user_id, order_number, status, total_amount,
            shipping_address_id, payment_method, notes, created_at, updated_at
        ) VALUES (
            user_rec.id,
            'ORD-' || to_char(order_date, 'YYYYMMDD') || '-' || lpad(order_counter::TEXT, 4, '0') || '-' || (random() * 1000 + random() * 100)::int,
            selected_status,
            total_amount,
            address_rec.id,
            selected_payment,
            order_note,
            order_date,
            order_date + CASE
                WHEN selected_status = 'delivered' THEN (random() * 7 * 24 * 60 * 60 || ' seconds')::INTERVAL
                ELSE '0 seconds'::INTERVAL
            END
        );

    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Генерируем 100 заказов
SELECT generate_orders(1000);