{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id
    , name
    , price 
    , inventory  
FROM {{ source('greenery', 'products') }}