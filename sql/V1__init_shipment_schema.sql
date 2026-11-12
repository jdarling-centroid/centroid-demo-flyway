-- V1: Baseline Coalition Shipment Tracking Schema
CREATE TABLE IF NOT EXISTS shipment_records (
    shipment_id SERIAL PRIMARY KEY,
    order_number VARCHAR(64) NOT NULL UNIQUE,
    customer_account_id VARCHAR(32) NOT NULL,
    origin_facility_code VARCHAR(16) NOT NULL,
    destination_facility_code VARCHAR(16) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'CREATED',
    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_shipments_order ON shipment_records(order_number);
CREATE INDEX IF NOT EXISTS idx_shipments_customer ON shipment_records(customer_account_id);
CREATE INDEX IF NOT EXISTS idx_shipments_status ON shipment_records(status);
