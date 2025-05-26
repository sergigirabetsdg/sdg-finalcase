SELECT
    CONCAT(part_id, supplier_id) AS partsupp_id,
    part_id,
    supplier_id,
    partsupp_quantity_available,
    partsupp_supply_cost
FROM {{ ref('stg_partsupp') }}

