{{
  config(
    materialized='view'
  )
}}

SELECT 
    order_id,
    product_id,
    quantity
FROM {{ source('raw', 'order_items') }}