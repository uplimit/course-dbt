{{
  config(
    materialized='view',
    enabled=true
  )
}}

select 
  order_id,
  user_id,
  address_id,
  tracking_id,
  promo_id,
  status,
  shipping_service,
  order_total,
  order_cost,
  shipping_cost,
  created_at,
  estimated_delivery_at,
  delivered_at

from {{ source('postgres', 'orders') }}