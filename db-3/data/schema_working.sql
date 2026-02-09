
CREATE TABLE IF NOT EXISTS orders_order (
    id SERIAL PRIMARY KEY,
    "created_at" TIMESTAMP,
    "marketer_id" VARCHAR(255),
    "order_number" VARCHAR(255),
    "product_id" VARCHAR(255),
    "seller_id" VARCHAR(255),
    "status" VARCHAR(255),
    "total_amount" NUMERIC,
);