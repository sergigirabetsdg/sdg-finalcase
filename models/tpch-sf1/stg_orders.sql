SELECT
    o_orderkey AS order_id,
    o_custkey AS customer_id,
    CASE o_orderstatus 
        WHEN 'F' THEN 'Finalized'
        WHEN 'O' THEN 'Open'
        WHEN 'P' THEN 'Pending'
        ELSE 'Unknown'
    END AS order_status,
    o_totalprice AS order_total_price,
    o_orderdate AS order_date,
    CAST(SPLIT_PART(o_orderpriority, '-', 1) AS INT) AS order_priority_level,
    CASE
        WHEN SPLIT_PART(o_orderpriority, '-', 1) = '4' THEN 'STANDARD'
        ELSE SPLIT_PART(o_orderpriority, '-', 2) 
    END AS order_priority_desc,
    CAST(REPLACE(o_clerk, 'Clerk#', '') AS INT) AS clerk_id
FROM {{ source('tpch_sf1', 'orders') }}
