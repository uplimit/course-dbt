
{{
  config(
    materialized='table'
  )
}}

select
    user_id, 
    total_orders,
    total_promos_used,
    recent_order_date,
    total_spent
from {{ ref('int_user_orders')}} 
