{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id AS product_guid,
    name,
    price,
    inventory
FROM {{ source('tutorial', 'products') }}