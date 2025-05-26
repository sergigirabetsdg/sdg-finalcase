SELECT
    c_custkey AS customer_id,
    c_address AS customer_address,
    c_nationkey AS nation_id,
    c_phone AS customer_phone,
    c_acctbal AS customer_account_balance,
    lower(c_mktsegment) AS customer_market_segment
FROM {{ source('tpch_sf1', 'customer') }}
