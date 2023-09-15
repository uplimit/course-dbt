{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id::VARCHAR(256),
    first_name::VARCHAR(256),
    last_name::VARCHAR(256),
    email::VARCHAR(1024),
    phone_number::VARCHAR(256),
    created_at::TIMESTAMP,
    updated_at::TIMESTAMP,
    address_id::VARCHAR(256)
FROM {{ source('postgres', 'users') }}