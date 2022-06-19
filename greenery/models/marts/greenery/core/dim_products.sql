{{
  config(
    materialized='table'
  )
}}

WITH dim_products AS (
    SELECT  
      product_guid
      , name
      , price
      , inventory
    FROM 
    {{
        ref('stg_greenery__products')
    }}
)

SELECT  
      product_guid
      , name AS product_name
      , price AS price_usd
      , inventory AS inventory_qty
FROM
    dim_products