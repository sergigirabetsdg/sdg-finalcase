with customer as (
    select * from {{ ref('trans_customer') }}
),

region as (
    select * from {{ ref('trans_region') }}
),

nation as (
    select * from {{ ref('trans_nation') }}
),

final as (
    select 
        c.customer_id,
        c.customer_address,
        c.customer_phone,
        c.customer_account_balance,
        c.customer_market_segment,
        n.nation_name,
        r.region_name
    from customer c 
    left join nation n on c.nation_id = n.nation_id 
    left join region r on n.region_id = r.region_id
) 

select * from final