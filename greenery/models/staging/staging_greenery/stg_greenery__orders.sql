{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__orders AS (
  SELECT * FROM {{source('src_greenery', 'orders')}}
)

, renamed_recast AS (
  SELECT
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at AS order_created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at AS order_estimated_delivery_at_utc,
    delivered_at AS order_delivered_at_utc,
    status AS order_status
  FROM src_greenery__orders
)

SELECT * FROM renamed_recast