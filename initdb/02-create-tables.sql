CREATE EXTENSION pgcrypto;  -- добавление расширения для генерации uuid

CREATE TABLE users (
    id uuid PRIMARY KEY default gen_random_uuid(), -- тут надо будет в модификациях таблиц изменить на uuid
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    date_of_birth DATE CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '14 years'),
    is_active BOOLEAN DEFAULT TRUE,
    is_email_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

COMMENT ON TABLE users IS 'Пользователи интернет-магазина';
COMMENT ON COLUMN users.date_of_birth IS 'Минимальный возраст 14 лет';

-- таблицы категории и товары

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    parent_category_id INTEGER REFERENCES categories(id),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    CHECK (sort_order >= 0)
);

COMMENT ON TABLE categories IS 'Категории товаров';


-- Таблица товаров

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES categories(id),
    sku VARCHAR(50) NOT NULL UNIQUE,  -- это уникальный идентификатор товара в системе компании, это бизнес-идентификатор пример - IPHONE14-128GB-BLACK
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    discount_price NUMERIC(10,2) CHECK (discount_price IS NULL OR discount_price > 0),
    stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),  -- количество товара на складе
    weight_kg NUMERIC(8,3) CHECK (weight_kg > 0),
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE, -- помечает товары как "рекомендуемые", "избранные" или "хиты продаж".
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    CHECK (discount_price IS NULL OR discount_price < price)
);

COMMENT ON TABLE products IS 'Товары магазина';


-- Таблица адресов пользователей

CREATE TABLE user_addresses (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    address_type VARCHAR(20) CHECK (address_type IN ('home', 'work', 'other')),
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    street VARCHAR(255) NOT NULL,
    apartment VARCHAR(50),
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE (user_id, address_type)
);

COMMENT ON TABLE user_addresses IS 'Адреса доставки пользователей';


-- заказы

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    order_number VARCHAR(50) NOT NULL UNIQUE,  -- номер заказа, пример ORD-000001
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled')),
    total_amount NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0),
    shipping_address_id INTEGER NOT NULL REFERENCES user_addresses(id),
    payment_method VARCHAR(50) CHECK (payment_method IN ('card', 'paypal', 'cash_on_delivery')),
    notes TEXT,  -- примечания к заказу, пример - позвонить за час до доставки
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE orders IS 'Заказы покупателей';


-- Таблица товаров в заказах

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    discount_amount NUMERIC(10,2) DEFAULT 0 CHECK (discount_amount >= 0),
    total_price NUMERIC(10,2) GENERATED ALWAYS AS (
        (unit_price - discount_amount) * quantity
    ) STORED,

    UNIQUE (order_id, product_id)
);

COMMENT ON TABLE order_items IS 'Товары в заказах';


-- Таблица платежей

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL UNIQUE REFERENCES orders(id),
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    transaction_id VARCHAR(100) UNIQUE,
    payment_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE payments IS 'Платежи по заказам';

