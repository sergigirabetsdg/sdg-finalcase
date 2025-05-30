WITH region AS (
    SELECT * FROM {{ ref('trans_region') }}
),

nation AS (
    SELECT * FROM {{ ref('trans_nation') }}
),

final AS (
    SELECT
        n.nation_id,
        r.region_id,
        n.nation_name,
        r.region_name
    FROM region r 
    LEFT JOIN nation n ON r.region_id = n.region_id
)

SELECT * FROM final