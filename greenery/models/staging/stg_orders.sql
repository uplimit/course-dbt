{{
  config(
    materialized='view'
  )
}}

SELECT 
    order_id,
    user_id,
    promo_id as promotion_id,
    address_id,
    created_at as order_creation_date,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at as est_delivery_date,
    delivered_at as delivered_date,
    status as order_status
FROM {{ source('raw', 'orders') }}