{{ config(
    materialized='incremental',
    unique_key=['l_orderkey', 'l_linenumber']
) }}

WITH lineitem AS (
    SELECT *
    FROM {{ source('tpch_sf1', 'lineitem') }}
    {% if is_incremental() %}
        WHERE l_commitdate > (SELECT MAX(l_commitdate) FROM {{ this }})
    {% endif %}
)

SELECT
    CONCAT(l_orderkey, l_linenumber) AS item_id,
    l_orderkey AS order_id,
    l_partkey AS part_id,
    l_suppkey AS supplier_id,
    l_linenumber AS item_line_number,
    l_quantity AS item_quantity,
    l_extendedprice AS item_extended_price,
    l_discount AS item_discount,
    l_tax AS item_tax,
    CASE l_returnflag 
        WHEN 'R' THEN 'Returned'
        WHEN 'A' THEN 'Accepted'
        WHEN 'N' THEN 'Not Returned'
        ELSE 'Unknown'  
    END AS item_return_flag,
    CASE l_linestatus
        WHEN 'O' THEN 'Open'
        WHEN 'F' THEN 'Filled'
        ELSE 'Unknown'
    END AS item_line_status,
    l_shipdate AS item_ship_date,
    l_commitdate AS item_commit_date,
    l_receiptdate AS item_receipt_date,
    lower(l_shipinstruct) AS item_shipping_instruction,
    lower(l_shipmode) AS item_shipping_mode
FROM lineitem
