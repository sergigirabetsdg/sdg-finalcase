SELECT
    s_suppkey AS supplier_id,
    s_address AS supplier_address,
    s_nationkey AS nation_id,
    s_phone AS supplier_phone,
    s_acctbal AS supplier_account_balance
FROM {{ source('tpch_sf1', 'supplier') }}
