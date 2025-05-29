SELECT
    supplier_id,
    nation_id,
    supplier_address,
    supplier_phone,
    supplier_account_balance
FROM {{ ref('stg_supplier') }}
