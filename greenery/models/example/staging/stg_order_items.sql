{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id AS order_guid,
    product_id AS product_guid,
    quantity
FROM {{ source('tutorial', 'order_items') }}