{{
  config(
    materialized='view'
  )
}}

SELECT 
    product_id,
    name as product_name,
    price as price_usd,
    inventory
FROM {{ source('src_greenery', 'products')}}