WITH customer AS (
    SELECT * FROM {{ ref('trans_customer') }}
),

region AS (
    SELECT * FROM {{ ref('trans_region') }}
),

nation AS (
    SELECT * FROM {{ ref('trans_nation') }}
),

final AS (
    SELECT 
        c.customer_id,
        c.customer_address,
        c.customer_phone,
        c.customer_account_balance,
        c.customer_market_segment,
        n.nation_name,
        r.region_name
    FROM customer c 
    left join nation n ON c.nation_id = n.nation_id 
    left join region r ON n.region_id = r.region_id
) 

SELECT * FROM final