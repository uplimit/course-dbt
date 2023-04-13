{{
  config(
    materialized='view',
    enabled=true
  )
}}

select 
  product_id,
  name as product,
  inventory,
  price

from {{ source('postgres', 'products') }}