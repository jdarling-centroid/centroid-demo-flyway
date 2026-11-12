-- R: Repeatable Migration for Coalition Business Functions (Updated in place when altered)
CREATE OR REPLACE FUNCTION fn_calculate_shipment_tax(
    p_amount NUMERIC,
    p_tax_rate NUMERIC DEFAULT 0.075
)
RETURNS NUMERIC AS $$
BEGIN
    IF p_amount IS NULL OR p_amount <= 0 THEN
        RETURN 0.00;
    END IF;
    RETURN ROUND(p_amount * p_tax_rate, 2);
END;
$$ LANGUAGE plpgsql;
