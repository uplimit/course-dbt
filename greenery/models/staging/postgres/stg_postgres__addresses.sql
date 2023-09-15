{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id::VARCHAR(256) as address_id,
    address::VARCHAR(8192) as address,
    zipcode::INTEGER as zipcode,
    state::VARCHAR(256) as state,
    country::VARCHAR(256) as counrty
FROM {{ source('postgres', 'addresses') }}