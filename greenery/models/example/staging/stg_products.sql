{{
  config(
    materialized='table'
  )
}}

SELECT 
product_id,
name,
price,
inventory
FROM {{ source('tutorial', 'products') }}
