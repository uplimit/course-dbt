{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id::VARCHAR(256),
    address::VARCHAR(8192),
    zipcode::INTEGER,
    state::VARCHAR(256),
    country::VARCHAR(256)
FROM {{ source('postgres', 'addresses') }}