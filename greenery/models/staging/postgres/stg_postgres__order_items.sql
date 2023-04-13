{{
  config(
    materialized='view',
    enabled=true
  )
}}

select 
  order_id,
  product_id,
  quantity

from {{ source('postgres', 'order_items') }}