with lineitem as (
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

final as (
    select
        li.item_id,
        li.order_id,
        li.part_id,
        li.supplier_id,
        li.item_line_number,
        li.item_quantity,
        li.item_extended_price,
        li.item_discount,
        li.item_tax,
        ROUND(li.item_extended_price * (1 - li.item_discount) * (1 + li.item_tax), 2) AS item_total_price,
        li.item_return_flag,
        li.item_line_status,
        li.item_ship_date,
        li.item_commit_date,
        li.item_receipt_date,
        li.item_shipping_instruction,
        li.item_shipping_mode,

        o.order_date,
        o.order_year,
        o.order_month,
        o.order_priority_level,
        o.order_priority_desc,

        p.part_name,
        p.part_manufacturer,
        p.part_brand,
        p.part_type,
        p.part_size,
        p.part_container,
        p.part_retail_price,

        s.supplier_address,
        s.nation_id,
        s.supplier_phone,
        s.supplier_account_balance,

    from lineitem li
    left join orders o on li.order_id = o.order_id
    left join part p on li.part_id = p.part_id
    left join supplier s on li.supplier_id = s.supplier_id
)

select * from final