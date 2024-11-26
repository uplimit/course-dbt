{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name, 
    inventory
FROM {{ ref('stg_products') }} 