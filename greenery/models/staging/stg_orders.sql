{{
    config(
    materialized='view'
  )
}}

select order_id,
  created_at
from public.orders