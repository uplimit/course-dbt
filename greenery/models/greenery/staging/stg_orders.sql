{{
  config(
    materialized='view'
  )
}}

SELECT 
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at as created_at_utc,
    order_cost as order_cost_usd,
    shipping_cost as shipping_cost_usd,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at as estimated_delivery_at_utc,
    delivered_at as delivered_at_utc,
    status
FROM {{ source('src_greenery', 'orders')}}