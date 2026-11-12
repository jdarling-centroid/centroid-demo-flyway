-- V2: Add Archival Tracking (Sample DDL Mutation for Demo Ticket COAL-101)
ALTER TABLE shipment_records 
    ADD COLUMN IF NOT EXISTS is_archived BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS archived_at TIMESTAMP WITH TIME ZONE NULL;

CREATE INDEX IF NOT EXISTS idx_shipments_archived ON shipment_records(is_archived);
