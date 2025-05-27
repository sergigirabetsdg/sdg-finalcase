SELECT
    order_id,
    customer_id,
    order_status,
    order_date,
    order_year,
    order_month,
    order_priority_level,
    order_priority_desc,
    clerk_id
FROM {{ ref('trans_orders') }}