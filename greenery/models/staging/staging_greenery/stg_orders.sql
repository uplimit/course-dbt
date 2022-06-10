{{
  config(
    materialized='table'
  )
}}

WITH src_greenery_orders AS (
  SELECT * FROM {{source('staging_greenery', 'orders')}}
)

, renamed_recast AS (
  SELECT
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
  FROM src_greenery_orders
)

SELECT * FROM renamed_recast

-- SELECT
--   order_id,
--   user_id,
--   promo_id,
--   address_id,
--   created_at,
--   order_cost,
--   shipping_cost,
--   order_total,
--   tracking_id,
--   shipping_service,
--   estimated_delivery_at,
--   delivered_at,
--   status
-- FROM {{ source('staging_greenery', 'orders') }}