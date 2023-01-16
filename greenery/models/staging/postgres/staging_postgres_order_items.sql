{{
  config(
    materialized='table'
  )
}}

select 
  ORDER_ID
  , PRODUCT_ID
  , QUANTITY
FROM {{ source('postgres', 'order_items') }}