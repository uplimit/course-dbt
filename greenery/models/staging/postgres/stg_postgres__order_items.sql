{{
  config(
    materialized='table'
  )
}}

SELECT 
   order_id::VARCHAR(256) as order_id,
   product_id::VARCHAR(256) as product_id,
   quantity::INTEGER as quantity
FROM {{ source('postgres', 'order_items') }}