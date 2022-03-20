{{
  config(
    materialized='table'
  )
}}

with ordered_items_per_order as
(SELECT
  order_id,
  sum(quantity) as num_of_prods_in_order
FROM {{ ref('dim_order_items')}}
GROUP BY order_id)

SELECT
  o.order_id,
  o.order_creation_date,
  o.shipping_service,
  o.order_total,
  o.order_status,
  pc.discount AS promo_code_discount,
  o.user_id,
  (o.delivered_date-o.est_delivery_date) as delivery_credibility,
  u.first_name AS user_first_name,
  oi.num_of_prods_in_order,
  case when o.promotion_id is null then 0  else 1 end as promo_used
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_promos') }} pc
  ON o.promotion_id = pc.promotion_id
LEFT JOIN {{ ref('stg_users') }} u
  ON o.user_id = u.user_id
LEFT JOIN ordered_items_per_order oi
ON o.order_id=oi.order_id