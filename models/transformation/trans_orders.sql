SELECT
    order_id,
    customer_id,
    CASE order_status 
        WHEN 'F' THEN 'Finalized'
        WHEN 'O' THEN 'Open'
        WHEN 'P' THEN 'Pending'
    END AS order_status,
    order_total_price,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    CAST(SPLIT_PART(order_priority, '-', 1) AS INT) AS order_priority_level,
    CASE
        WHEN SPLIT_PART(order_priority, '-', 1) = '4' THEN 'STANDARD'
        ELSE SPLIT_PART(order_priority, '-', 2) 
    END AS order_priority_desc,
    CAST(REPLACE(clerk_id, 'Clerk#', '') AS INT) AS clerk_id
FROM {{ ref('stg_orders') }}
