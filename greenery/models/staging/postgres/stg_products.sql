{{ 
  config(
    materialized='view'
  ) 
}}

with products as (

    select * from {{ source('_postgres__sources', 'products') }}

)

select
    product_id, 
    name,
    price, 
    inventory

from products