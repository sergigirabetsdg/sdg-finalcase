SELECT
    nation_id,
    lower(nation_name) AS nation_name,
    region_id
FROM {{ ref('stg_nation') }}
