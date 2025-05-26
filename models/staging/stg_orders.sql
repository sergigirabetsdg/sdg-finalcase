SELECT
    o_orderkey AS order_id,
    o_custkey AS customer_id,
    o_orderstatus AS order_status,
    o_totalprice AS order_total_price,
    o_orderdate AS order_date,
    o_orderpriority AS order_priority,
    o_clerk AS clerk_id
FROM {{ source('tpch_sf1', 'orders') }}
