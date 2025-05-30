{{ config(
    materialized='incremental',
    unique_key=['order_id', 'item_line_number']
) }}
WITH max_commitdate AS (
    SELECT MAX(item_commit_date) AS last_commitdate
    FROM {{ this }}
),
lineitem AS (
    SELECT *
    FROM {{ source('tpch_sf1', 'lineitem') }}
    {% if is_incremental() %}
        WHERE l_commitdate > (SELECT last_commitdate FROM max_commitdate)
    {% endif %}
)
SELECT
    l_orderkey AS order_id,
    l_partkey AS part_id,
    l_suppkey AS supplier_id,
    l_linenumber AS item_line_number,
    l_quantity AS item_quantity,
    l_extendedprice AS item_extended_price,
    l_discount AS item_discount,
    l_tax AS item_tax,
    l_returnflag AS item_return_flag,
    l_linestatus AS item_line_status,
    l_shipdate AS item_ship_date,
    l_commitdate AS item_commit_date,
    l_receiptdate AS item_receipt_date,
    l_shipinstruct AS item_shipping_instruction,
    l_shipmode AS item_shipping_mode
FROM lineitem