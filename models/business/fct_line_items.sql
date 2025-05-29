WITH line_item AS (
        SELECT * from {{ ref('trans_lineitem') }}
),

orders AS  (
    SELECT * from {{ ref ('dim_orders' )}}
),

part AS (
    SELECT * from {{ ref ('dim_part') }}
),

supplier AS (
    SELECT * from {{ ref('dim_supplier') }}
),

partsupp AS (
    SELECT * from {{ ref('trans_partsupp') }}
), 
customer AS (
    SELECT * from {{ ref('dim_customer') }}
),

calculated_items_prices AS (
    SELECT 
        li.*,
        ps.partsupp_supply_cost,
        li.item_extended_price * (1 - li.item_discount) AS item_net_price,
        li.item_quantity * ps.partsupp_supply_cost AS item_total_cost
    FROM line_item li
    left join partsupp ps ON 
        li.part_id = ps.part_id
        AND li.supplier_id = ps.supplier_id
),

final AS (
    SELECT
        --- PK ---
        ci.item_id,
        
        --- FK ---  
        ci.order_id,
        cust.customer_id,
        ci.part_id,
        ci.supplier_id,
        
        --- metrics ---
        ci.item_quantity,
        ci.item_extended_price,
        ci.item_discount,
        ci.item_tax,

        --- calculated metrics ---
        {{calc_discounted_price('ci.item_extended_price', 'ci.item_discount', 'ci.item_tax')}} AS item_total_price,
        {{ calc_unit_margin('ci.item_net_price', 'ci.item_quantity', 'ci.partsupp_supply_cost') }} AS item_unit_margin, 
        {{calc_total_margin('ci.item_net_price', 'ci.item_total_cost')}} AS item_total_margin,
        {{ calc_margin_pct('ci.item_net_price', 'ci.item_total_cost') }} AS item_margin_pct,
        {{ calc_discount_from_retail('p.part_retail_price', 'ci.item_net_price', 'ci.item_quantity') }} AS item_discount_from_retail,
        {{ calc_item_delivery("'day'", 'ci.item_ship_date', 'ci.item_receipt_date') }} AS item_delivery_days

    FROM calculated_items_prices ci
    left join orders o ON ci.order_id = o.order_id
    left join customer cust ON o.customer_id = cust.customer_id
    left join part p ON ci.part_id = p.part_id
    left join supplier s ON ci.supplier_id = s.supplier_id
)

SELECT * FROM final