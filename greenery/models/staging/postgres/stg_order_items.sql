{{ 
  config(
    materialized='view'
  ) 
}}

with order_items as (

    select * from {{ source('_postgres__sources', 'order_items') }}

)

select 
    order_id, 
    product_id, 
    quantity

from order_items