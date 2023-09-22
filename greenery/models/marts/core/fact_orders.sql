{{
  config(
    materialized='table'
  )
}}

SELECT
a.order_id, 
a.user_id, 
a.promo_id,
c.discount as promo_discount,
c.status as promo_status,
a.address_id,
DATE(a.created_at) as order_date,
a.order_cost, 
a.order_total,
a.tracking_id,
a.shipping_service,
a.shipping_cost,
DATE(a.estimated_delivery_at) as estimated_delivery_at,
DATE(a.delivered_at) as delivered_at,
 order_status,
b.product_id,
b.quantity


FROM {{ ref('stg_orders') }}  a
LEFT JOIN {{ ref('stg_order_items') }}  b
ON a.order_id = b.order_id
LEFT JOIN {{ ref('stg_promos') }} c
ON a.promo_id = c.promo_id