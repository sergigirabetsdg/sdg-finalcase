-- Test unitario: La fecha de recepción debe ser posterior a la de envío

SELECT *
FROM {{ ref('stg_lineitem') }}
WHERE item_receipt_date < item_ship_date
