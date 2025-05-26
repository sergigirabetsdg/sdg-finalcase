SELECT
    CONCAT(order_id, item_line_number) AS item_id,
    order_id,
    part_id,
    supplier_id,
    item_line_number,
    item_quantity,
    item_extended_price,
    item_discount,
    item_tax,
    CASE item_return_flag 
        WHEN 'R' THEN 'Returned'
        WHEN 'A' THEN 'Accepted'
        WHEN 'N' THEN 'Not Returned'
        ELSE 'Unknown'  
    END AS item_return_flag,
    CASE item_line_status
        WHEN 'O' THEN 'Open'
        WHEN 'F' THEN 'Filled'
        ELSE 'Unknown'
    END AS item_line_status,
    item_ship_date,
    item_commit_date,
    item_receipt_date,
    lower(item_shipping_instruction) AS item_shipping_instruction,
    lower(item_shipping_mode) AS item_shipping_mode
FROM {{ ref('stg_lineitem') }}
