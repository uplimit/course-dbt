{{
  config(
    materialized='table'
  )
}}

SELECT 
    promo_id::VARCHAR(256),
    discount::INTEGER,
    status::VARCHAR(128)
FROM {{ source('postgres', 'promos') }}