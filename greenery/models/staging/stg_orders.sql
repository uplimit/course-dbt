{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    user_id,
    promo_id,
    address_id,
    DATE(created_at) as created_at,
    order_cost,
    shipping_cost,
    order_total,
    shipping_service,
    DATE(estimated_delivery_at) as estimated_delivery_at,
    DATE(delivered_at) as delivered_at,
    status
FROM {{ source('postgres', 'orders') }}