SELECT
    r_regionkey AS region_id,
    r_name AS region_name
FROM {{ source('tpch_sf1', 'region') }}