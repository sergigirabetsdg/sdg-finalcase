SELECT 
    customer_id,
    nation_id,
    customer_address,
    customer_phone,
    customer_account_balance,
    customer_market_segment
FROM {{ ref('trans_customer') }}  
