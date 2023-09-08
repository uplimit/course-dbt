{{ config(materialized='table') }}

select
  product_id,
  name,
  price,
  inventory 
from {{ source('_postgres__sources', 'products')}} products