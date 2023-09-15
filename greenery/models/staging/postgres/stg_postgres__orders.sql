{{
  config(
    materialized='table'
  )
}}

SELECT 
   order_id::VARCHAR(256) as order_id,
   promo_id::VARCHAR(256) as promo_id,
   user_id::VARCHAR(256) as user_id,
   address_id::VARCHAR(256) as address_id,
   created_at::TIMESTAMP as created_at,
   order_cost::REAL as order_cost,
   shipping_cost::REAL as shipping_cost,
   order_total::REAL as order_total,
   tracking_id::VARCHAR(256) as tracking_id,
   shipping_service::VARCHAR(128) as shipping_service,
   estimated_delivery_at::TIMESTAMP as estimated_delivery_at,
   delivered_at::TIMESTAMP as delivered_at,
   status::VARCHAR(128) as status
FROM {{ source('postgres', 'orders') }}