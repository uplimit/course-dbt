{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id::VARCHAR(256) as product_id,
    name::VARCHAR(1024) as name,
    price::REAL as price,
    inventory::INTEGER as inventory
FROM {{ source('postgres', 'products') }}