CREATE OR REPLACE FUNCTION generate_payments()
RETURNS VOID AS $$
DECLARE
    order_rec RECORD;
    selected_status TEXT;
    payment_date TIMESTAMPTZ;
    transaction_id TEXT;
BEGIN
    FOR order_rec IN
        SELECT
            o.id,
            o.order_number,
            o.total_amount,
            o.payment_method,
            o.status as order_status,
            o.created_at as order_date
        FROM orders o
        WHERE NOT EXISTS (SELECT 1 FROM payments p WHERE p.order_id = o.id)
    LOOP
        -- логика соответствия статусов
        selected_status := CASE
            -- Отмененный заказ
            WHEN order_rec.order_status = 'cancelled' THEN
                CASE
                    -- 70% шанс что оплата была и ее вернули
                    WHEN random() < 0.7 THEN 'refunded'
                    -- 30% шанс что оплата не прошла
                    ELSE 'failed'
                END

            -- Доставленный заказ - ДОЛЖЕН быть оплачен
            WHEN order_rec.order_status = 'delivered' THEN 'completed'

            -- Отправленный заказ - обычно оплачен
            WHEN order_rec.order_status = 'shipped' THEN
                CASE
                    -- 90% оплачен, 10% наложенный платеж (pending)
                    WHEN random() < 0.9 THEN 'completed'
                    ELSE 'pending'
                END

            -- В обработке - может быть разный статус платежа
            WHEN order_rec.order_status = 'processing' THEN
                CASE
                    WHEN random() < 0.6 THEN 'completed'  -- уже оплатили
                    WHEN random() < 0.3 THEN 'pending'    -- ждут оплату
                    ELSE 'failed'                         -- оплата не прошла
                END

            -- Подтвержденный - обычно ожидает оплату
            WHEN order_rec.order_status = 'confirmed' THEN
                CASE
                    WHEN random() < 0.4 THEN 'completed'  -- предоплата
                    WHEN random() < 0.8 THEN 'pending'    -- ждет оплату
                    ELSE 'failed'                         -- неудачная попытка
                END

            -- Ожидающий - обычно не оплачен
            WHEN order_rec.order_status = 'pending' THEN
                CASE
                    WHEN random() < 0.2 THEN 'completed'  -- редкий случай
                    WHEN random() < 0.5 THEN 'pending'    -- ожидает
                    ELSE 'failed'                         -- неудача
                END

            -- На всякий случай
            ELSE 'pending'
        END;

        -- Логика дат платежа
        IF selected_status = 'completed' THEN
            payment_date := order_rec.order_date + (random() * 2 * 60 * 60 || ' seconds')::INTERVAL; -- до 2 часов
        ELSIF selected_status = 'refunded' THEN
            payment_date := order_rec.order_date + ((1 + random() * 2) * 24 * 60 * 60 || ' seconds')::INTERVAL; -- 1-3 дня
        ELSIF selected_status = 'failed' THEN
            payment_date := order_rec.order_date + (random() * 1 * 60 * 60 || ' seconds')::INTERVAL; -- до 1 часа
        ELSE -- pending
            payment_date := NULL; -- еще не оплачен
        END IF;

        -- ID транзакции только для завершенных операций
        IF selected_status IN ('completed', 'refunded') THEN
            transaction_id := 'TXN-' || to_char(COALESCE(payment_date, order_rec.order_date), 'YYYYMMDD') || '-' || lpad(order_rec.id::TEXT, 6, '0');
        ELSE
            transaction_id := NULL;
        END IF;

        -- Вставляем платеж
        INSERT INTO payments (
            order_id, payment_method, payment_status, amount,
            transaction_id, payment_date, created_at, updated_at
        ) VALUES (
            order_rec.id,
            order_rec.payment_method,
            selected_status,
            order_rec.total_amount,
            transaction_id,
            payment_date,
            order_rec.order_date,
            COALESCE(payment_date, order_rec.order_date)
        );

    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT generate_payments();
