CREATE OR REPLACE FUNCTION update_orders_total_amount()
RETURNS VOID AS $$
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT COALESCE(SUM(total_price), 0)
        FROM order_items
        WHERE order_items.order_id = orders.id
    )
    WHERE id IN (
        SELECT DISTINCT order_id
        FROM order_items
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION generate_order_items()
RETURNS VOID AS $$
DECLARE
    order_rec RECORD;
    product_rec RECORD;
    items_count INTEGER;
    i INTEGER;
    available_products INTEGER[];
    selected_product_id INTEGER;
    unit_price NUMERIC(10,2);
    discount_amount NUMERIC(10,2);
    quantity INTEGER;
BEGIN
    -- Получаем все активные товары с ценами
    SELECT ARRAY_AGG(id) INTO available_products
    FROM products
    WHERE is_active = true;

    -- Если нет товаров, выходим
    IF available_products IS NULL OR array_length(available_products, 1) = 0 THEN
        RAISE NOTICE 'No active products found';
        RETURN;
    END IF;

    FOR order_rec IN SELECT id, total_amount FROM orders LOOP
        -- От 1 до 5 товаров в заказе
        items_count := floor(random() * 5) + 1;

        -- Сбрасываем массив использованных товаров для этого заказа
        FOR i IN 1..items_count LOOP
            -- Выбираем случайный товар из доступных
            selected_product_id := available_products[floor(random() * array_length(available_products, 1)) + 1];

            -- Получаем данные товара
            SELECT price, discount_price INTO product_rec
            FROM products
            WHERE id = selected_product_id;

            -- Определяем количество (1-3 штуки)
            quantity := floor(random() * 3) + 1;

            -- Берем актуальную цену товара
            unit_price := product_rec.price;

            -- Определяем скидку (если есть discount_price у товара)
            IF product_rec.discount_price IS NOT NULL THEN
                discount_amount := (unit_price - product_rec.discount_price)::NUMERIC(10,2);
            ELSE
                discount_amount := 0;
            END IF;

            -- Пытаемся вставить позицию заказа
            BEGIN
                INSERT INTO order_items (
                    order_id, product_id, quantity, unit_price, discount_amount
                ) VALUES (
                    order_rec.id,
                    selected_product_id,
                    quantity,
                    unit_price,
                    discount_amount
                );
            EXCEPTION
                WHEN unique_violation THEN
                    -- Если товар уже есть в заказе, пропускаем
                    CONTINUE;
            END;

        END LOOP;
    END LOOP;

    -- Обновляем общую сумму заказов на основе позиций
    PERFORM update_orders_total_amount();
END;
$$ LANGUAGE plpgsql;

-- Генерируем позиции для всех заказов
SELECT generate_order_items();
