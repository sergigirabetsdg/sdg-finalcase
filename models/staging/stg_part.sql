SELECT
    p_partkey AS part_id,
    p_name AS part_name,
    p_mfgr AS part_manufacturer,
    p_brand AS part_brand,
    p_type AS part_type,
    p_size AS part_size,
    p_container AS part_container,
    p_retailprice AS part_retail_price
FROM {{ source('tpch_sf1', 'part') }}