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
products AS (
  SELECT * 
  FROM {{ref ('stg_products')}}
)

SELECT 
  DISTINCT  
  o.order_id,
  o.created_at,
  o.user_id,
  p.name AS product_name,
  p.product_id,
  COALESCE(oi.quantity, 0) AS order_quantity,
  p.price AS product_price,
  COALESCE(oi.quantity * p.price, 0) AS order_amount

FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON p.product_id = oi.product_id