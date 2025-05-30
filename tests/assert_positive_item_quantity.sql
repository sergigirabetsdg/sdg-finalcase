---Test unitario: La cantidad debe ser positiva o 0, pero nunca negativa
SELECT *
FROM {{ ref('stg_lineitem') }}
WHERE item_quantity <= 0
