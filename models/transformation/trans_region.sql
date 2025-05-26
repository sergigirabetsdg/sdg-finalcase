SELECT
    region_id,
    lower(region_name) AS region_name
FROM {{ ref('stg_region') }}