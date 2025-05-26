SELECT
    p_partkey as part_id,
    p_name as part_name,
    REPLACE(p_mfgr, 'Manufacturer#', '') AS part_manufacturer,
    REPLACE(p_brand, 'Brand#', '') AS part_brand,
    lower(p_type) AS part_type,
    p_size AS part_size,
    lower(p_container) AS part_container,
    p_retailprice AS part_retail_price
FROM {{ source('tpch_sf1', 'part') }}