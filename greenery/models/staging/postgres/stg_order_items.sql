{{ config(materialized='table') }}

select
  order_id,
  product_id,
  quantity
from {{ source('_postgres__sources', 'order_items')}} order_items