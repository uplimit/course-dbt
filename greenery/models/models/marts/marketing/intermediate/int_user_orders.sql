{{ config (materialized='table')}}

WITH user_order_count as (
SELECT
    user_id,
    count(order_id) as order_count
FROM {{ref('stg_greenery_orders')}}
WHERE order_status = 'delivered'
GROUP BY 1
)

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.user_address_id,
    ua.address,
    ua.zipcode,
    ua.state,
    ua.country,
    o.address_id,
    o.order_created_at_utc,
    o.order_cost,
    shipping_cost,
    order_total,
    order_tracking_id,
    shipping_service,
    order_estimated_delivery_at_utc,
    order_delivered_at_utc,
    order_status,
    COALESCE(order_count,0) as user_order_count
FROM {{ref('stg_greenery_users')}} u
JOIN {{ref('stg_greenery_orders')}} o on o.user_id = u.user_id
JOIN {{ref('stg_greenery_addresses')}} ua on ua.address_id = u.user_address_id
LEFT JOIN user_order_count uc on uc.user_id = u.user_id