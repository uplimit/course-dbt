{{
  config(
    materialized='view'
  )
}}

SELECT 
-- create a unique ID for this table 
  order_id || product_id as order_product_id 
    , order_id  
    , product_id
    , quantity 
FROM {{ source('greenery', 'order_items') }}