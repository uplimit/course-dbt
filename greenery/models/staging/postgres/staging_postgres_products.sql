{{
  config(
    materialized='table'
  )
}}

select 
  PRODUCT_ID
  , NAME
  , PRICE
  , INVENTORY
FROM {{ source('postgres', 'products') }}