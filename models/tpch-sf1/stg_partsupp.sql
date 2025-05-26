SELECT
    CONCAT(ps_partkey, ps_suppkey) AS partsupp_id,
    ps_partkey AS part_id,
    ps_suppkey AS supplier_id,
    ps_availqty AS partsupp_quantity_available,
    ps_supplycost AS partsupp_supply_cost
FROM {{ source('tpch_sf1', 'partsupp') }}

