{{
  config(
    materialized='table'
  )
}}

WITH orders AS (
    SELECT * 
    FROM {{ref ('stg_orders')}}
),

order_items AS (
    SELECT * 
    FROM {{ref ('stg_order_items')}}
),

promos AS (
    SELECT *
    FROM {{ref ('stg_promos')}}
)

SELECT
DISTINCT   
o.order_id,
o.created_at,
o.status,
o.user_id,
o.address_id,
o.order_total,
COALESCE(pr.discount, 0) AS promo_discount,
COALESCE(o.order_cost, 0) AS order_cost,
COALESCE(o.shipping_cost, 0) AS shipping_cost,
o.shipping_service,
o.estimated_delivery_at,
o.delivered_at

FROM orders o
LEFT JOIN order_items oi 
ON o.order_id = oi.order_id
LEFT JOIN promos pr
ON o.promo_id = pr.promo_id



