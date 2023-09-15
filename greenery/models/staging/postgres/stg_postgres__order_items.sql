{{
  config(
    materialized='table'
  )
}}

SELECT 
   order_id::VARCHAR(256),
   product_id::VARCHAR(256),
   quantity::INTEGER
FROM {{ source('postgres', 'order_items') }}