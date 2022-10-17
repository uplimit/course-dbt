
{{
  config(
    materialized='table'
  )
}}

select
  product_id,
  name,
  price,
  inventory 
from {{ ref('stg_products')}} products