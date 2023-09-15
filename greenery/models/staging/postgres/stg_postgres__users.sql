{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id::VARCHAR(256) as user_id,
    first_name::VARCHAR(256) as first_name,
    last_name::VARCHAR(256) as last_name,
    email::VARCHAR(1024) as email,
    phone_number::VARCHAR(256) as phone_number,
    created_at::TIMESTAMP as created_at,
    updated_at::TIMESTAMP as updated_at,
    address_id::VARCHAR(256) as address_id
FROM {{ source('postgres', 'users') }}