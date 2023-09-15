{{
  config(
    materialized='table'
  )
}}

SELECT 
    promo_id::VARCHAR(256) as promo_id,
    discount::INTEGER as discount,
    status::VARCHAR(128) as status
FROM {{ source('postgres', 'promos') }}