-- db-2 phppos_sales schema for PostgreSQL
-- Production schema for point-of-sale system

DROP TABLE IF EXISTS phppos_sales CASCADE;

CREATE TABLE phppos_sales (
    id SERIAL PRIMARY KEY,
    sale_time TIMESTAMP,
    customer_id INTEGER,
    employee_id INTEGER,
    comment TEXT,
    show_comment_on_receipt INTEGER DEFAULT 0,
    invoice_number VARCHAR(255),
    sale_id INTEGER,
    payment_type VARCHAR(100),
    cc_ref_no VARCHAR(255),
    auth_code VARCHAR(255),
    deleted_by INTEGER,
    deleted INTEGER DEFAULT 0,
    suspended INTEGER DEFAULT 0,
    allocated INTEGER DEFAULT 0,
    store_account_payment NUMERIC(10,2) DEFAULT 0,
    location_id INTEGER,
    erp_integration TEXT,
    etims_invoice_number VARCHAR(255),
    etims_scu_id VARCHAR(255),
    etims_cu_inv_no VARCHAR(255),
    etims_internal_data TEXT,
    etims_receipt_signature TEXT,
    etims_signature_link TEXT,
    etims_version VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sale_date DATE
);

CREATE INDEX idx_phppos_sales_sale_time ON phppos_sales(sale_time);
CREATE INDEX idx_phppos_sales_customer_id ON phppos_sales(customer_id);
CREATE INDEX idx_phppos_sales_employee_id ON phppos_sales(employee_id);
CREATE INDEX idx_phppos_sales_location_id ON phppos_sales(location_id);
