-- Test unitario: Los descuentos deben estar entre 0 y 1

SELECT *
FROM {{ ref('stg_lineitem') }}
WHERE item_discount < 0 OR item_discount > 1
