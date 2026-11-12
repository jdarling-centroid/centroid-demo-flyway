-- U2: Rollback Archival Tracking (Paired Rollback for V2)
DROP INDEX IF EXISTS idx_shipments_archived;

ALTER TABLE shipment_records 
    DROP COLUMN IF EXISTS archived_at,
    DROP COLUMN IF EXISTS is_archived;
