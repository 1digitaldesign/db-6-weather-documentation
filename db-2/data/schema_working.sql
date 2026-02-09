
CREATE TABLE IF NOT EXISTS phppos_sales (
    id SERIAL PRIMARY KEY,
    "comment" VARCHAR(255),
    "customer_id" VARCHAR(255),
    "employee_id" VARCHAR(255),
    "sale_date" TIMESTAMP,
    "sale_id" VARCHAR(255),
    "sale_time" TIMESTAMP,
);