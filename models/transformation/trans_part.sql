SELECT
    part_id,
    part_name,
    REPLACE(part_manufacturer, 'Manufacturer#', '') AS part_manufacturer,
    REPLACE(part_brand, 'Brand#', '') AS part_brand,
    lower(part_type) AS part_type,
    part_size,
    lower(part_container) AS part_container,
    part_retail_price
FROM {{ ref('stg_part') }}