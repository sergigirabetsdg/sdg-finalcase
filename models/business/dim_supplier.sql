with supplier as (
    select * from {{ ref('stg_supplier') }}
),

region as (
    select * from {{ ref('trans_region') }}
),

nation as (
    select * from {{ ref('trans_nation') }}
),

final as (
    select
        s.supplier_id,
        s.supplier_address,
        s.supplier_phone,
        s.supplier_account_balance,
        n.nation_name,
        r.region_name
    from supplier s
    left join nation n ON s.nation_id = n.nation_id
    left join region r ON n.region_id = r.region_id
)

select * from final