{{
  config(
    materialized='table'
  )
}}


select
    o.user_id, 
    count (distinct o.order_id) as total_orders,
    count(o.promo_id) total_promos_used,
    max( o.created_at) recent_order_date,
    sum(o.order_cost) total_spent
from {{ ref ('stg_orders') }} o
group by o.user_id

