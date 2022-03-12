{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id AS order_guid,
    user_id AS user_guid,
    promo_id,
    address_id AS address_guid,
    created_at,
    order_cost,
    shipping_cost
    order_total,
    tracking_id AS tracking_guid,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
FROM {{ source('tutorial', 'orders') }}