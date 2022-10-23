{{
  config(
    materialized='table'
  )
}}

WITH product_events AS (
    SELECT * FROM {{ ref('int_product_events') }}
),

product_orders AS (
    SELECT * FROM {{ ref('fact_ordered_products') }}
),

product_conversions AS (
    SELECT * FROM {{ ref('int_product_conversions')}}
)

SELECT
    po.product_id,
    po.product_name,
    po.product_price,
    po.order_quantity,
    po.order_amount,
    pe.add_to_cart_total,
    pe.checkout_total,
    pe.package_shipped_total,
    pc.converted_sessions,
    pc.total_sessions,
    pc.conversion_rate
FROM product_orders po
LEFT JOIN product_events pe
ON po.product_id = pe.product_id
LEFT JOIN product_conversions pc
ON po.product_id = pc.product_id

