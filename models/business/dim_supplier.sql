WITH supplier AS (
    SELECT * FROM {{ ref('stg_supplier') }}
),

region AS (
    SELECT * FROM {{ ref('trans_region') }}
),

nation AS (
    SELECT * FROM {{ ref('trans_nation') }}
),

final AS (
    SELECT
        s.supplier_id,
        s.supplier_address,
        s.supplier_phone,
        s.supplier_account_balance,
        n.nation_name,
        r.region_name
    FROM supplier s
    left join nation n ON s.nation_id = n.nation_id
    left join region r ON n.region_id = r.region_id
)

SELECT * FROM final