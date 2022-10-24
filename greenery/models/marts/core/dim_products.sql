
{{
  config(
    materialized='table'
  )
}}

select
  p.product_id,
  p.name,
  p.price,
  p.inventory,
  cr.total_orders,
  cr.total_sessions,
  cr.conversion_rate
from {{ ref('stg_products')}} p
join  {{ ref('int_product_conv_rate')}} cr