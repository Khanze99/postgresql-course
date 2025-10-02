CREATE TABLE product_images (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(200),
    sort_order INTEGER DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE (product_id, image_url),
    CHECK (sort_order >= 0)
);

COMMENT ON TABLE product_images IS 'Изображения товаров';


CREATE TABLE product_reviews (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(200),
    comment TEXT,
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE (product_id, user_id)
);

COMMENT ON TABLE product_reviews IS 'Отзывы о товарах';

CREATE TABLE promotions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    discount_type VARCHAR(20) CHECK (discount_type IN ('percentage', 'fixed_amount')),
    discount_value NUMERIC(10,2) NOT NULL CHECK (discount_value > 0),
    minimum_order_amount NUMERIC(10,2) CHECK (minimum_order_amount >= 0),
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    CHECK (end_date > start_date),
    CHECK (discount_type = 'percentage' AND discount_value <= 100 OR discount_type = 'fixed_amount')
);

COMMENT ON TABLE promotions IS 'Акции и скидки';