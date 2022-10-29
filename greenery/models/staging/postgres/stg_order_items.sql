{{
  config(
    materialized='view'
  )
}}

SELECT 
    order_id,
    product_id,
    quantity

FROM {{ source('postgres', 'order_items') }}