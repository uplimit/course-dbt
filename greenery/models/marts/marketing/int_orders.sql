{{
  config(
    materialized='view'
  )
}}

WITH orders AS (
  SELECT * FROM {{ref ('stg_orders')}}
),

promos AS (
  SELECT * FROM {{ref ('stg_promos')}}
)

SELECT
  DISTINCT
  o.order_id,
  o.created_at,
  o.status,
  o.user_id,
  o.address_id,
  COALESCE(o.order_total, 0) AS order_total,
  p.status AS promo_status,
  COALESCE(p.discount, 0) AS promo_discount,
  COALESCE(o.order_cost, 0) AS order_cost,
  COALESCE(o.shipping_cost, 0) AS shipping_cost,
  o.shipping_service,
  o.estimated_delivery_at,
  o.delivered_at

FROM orders o
LEFT JOIN promos p ON o.promo_id = p.promo_id


