SELECT
    customer_id,
    customer_address,
    nation_id,
    customer_phone,
    customer_account_balance,
    LOWER(customer_market_segment) AS customer_market_segment
FROM {{ ref('stg_customer') }}
