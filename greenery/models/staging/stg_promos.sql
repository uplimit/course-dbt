{{
  config(
    materialized='view'
  )
}}

SELECT 
    promo_id as promotion_id,
    discount,
    status    
FROM {{ source('raw', 'promos') }}