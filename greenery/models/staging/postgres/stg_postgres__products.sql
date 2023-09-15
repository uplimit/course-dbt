{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id::VARCHAR(256),
    name::VARCHAR(1024),
    price::REAL,
    inventory::INTEGER
FROM {{ source('postgres', 'products') }}