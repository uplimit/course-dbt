{{
  config(
    materialized='view'
  )
}}

select 
  PRODUCT_ID
  , NAME
  , PRICE
  , INVENTORY
FROM {{ source('postgres', 'products') }}