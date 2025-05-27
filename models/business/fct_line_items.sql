with line_item as (
        select * from {{ ref('trans_lineitem') }}
),

orders as  (
    select * from {{ ref ('dim_orders' )}}
),

part as (
    select * from {{ ref ('dim_part') }}
),

supplier as (
    select * from {{ ref('dim_supplier') }}
),

partsupp as (
    select * from {{ ref('trans_partsupp') }}
),

calculated_items_prices as (
    select 
        li.*,
        ps.partsupp_supply_cost,
        li.item_extended_price * (1 - li.item_discount) AS item_net_price,
        li.item_quantity * ps.partsupp_supply_cost AS item_total_cost
    from line_item li
    left join partsupp ps on 
        li.part_id = ps.part_id
        AND li.supplier_id = ps.supplier_id
),

final as (
    select
        --- composed PK ---
        ci.item_id,
        ci.order_id,
        o.customer_id,
        ci.part_id,
        ci.supplier_id,
        
        --- metrics ---
        ci.item_quantity,
        ci.item_extended_price,
        ci.item_discount AS item_discount_from_retail,
        ci.item_tax,

        --- calculated metrics ---
        ROUND(ci.item_net_price * (1 + ci.item_tax), 2) AS item_total_price,
        ROUND((ci.item_net_price / NULLIF(ci.item_quantity, 0)) - ci.partsupp_supply_cost, 2) AS item_unit_margin,
        ROUND(ci.item_net_price - ci.item_total_cost, 2) AS item_total_margin,
        ROUND(100 * ((ci.item_net_price - ci.item_total_cost) / NULLIF(ci.item_total_cost, 0)), 2) AS item_margin_pct,
        ROUND((p.part_retail_price - (ci.item_net_price / NULLIF(ci.item_quantity, 0))), 2) AS item_discount_from_retail,
        DATEDIFF(day, ci.item_ship_date, ci.item_receipt_date) AS item_delivery_days

    from calculated_items_prices ci
    left join orders o on ci.order_id = o.order_id
    left join part p on ci.part_id = p.part_id
    left join supplier s on ci.supplier_id = s.supplier_id
)

select * from final