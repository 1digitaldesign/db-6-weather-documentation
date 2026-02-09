-- db-3 orders_order schema for PostgreSQL
-- Production schema for e-commerce order management system

DROP TABLE IF EXISTS orders_order CASCADE;

CREATE TABLE orders_order (
    id VARCHAR(50) PRIMARY KEY,
    order_number VARCHAR(255),
    customer_email VARCHAR(255),
    customer_name VARCHAR(255),
    customer_phone VARCHAR(50),
    shipping_address TEXT,
    quantity INTEGER DEFAULT 1,
    unit_price NUMERIC(12,2),
    subtotal NUMERIC(12,2),
    shipping_fee NUMERIC(10,2) DEFAULT 0,
    tax_amount NUMERIC(10,2) DEFAULT 0,
    total_amount NUMERIC(12,2),
    commission_rate NUMERIC(5,4),
    commission_amount NUMERIC(12,2),
    status VARCHAR(50) DEFAULT 'pending',
    payment_status VARCHAR(50),
    payment_method VARCHAR(50),
    payment_reference VARCHAR(255),
    paystack_reference VARCHAR(255),
    refund_status VARCHAR(50),
    refund_amount NUMERIC(12,2),
    refund_reason TEXT,
    refund_requested_at TIMESTAMP,
    refund_processed_at TIMESTAMP,
    attribution_cookie_id VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    paid_at TIMESTAMP,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP,
    marketer_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    customer_order_id VARCHAR(50)
);

CREATE INDEX idx_orders_order_status ON orders_order(status);
CREATE INDEX idx_orders_order_created_at ON orders_order(created_at);
CREATE INDEX idx_orders_order_marketer_id ON orders_order(marketer_id);
CREATE INDEX idx_orders_order_product_id ON orders_order(product_id);
CREATE INDEX idx_orders_order_seller_id ON orders_order(seller_id);
CREATE INDEX idx_orders_order_total_amount ON orders_order(total_amount);
