{{
  config(
    materialized='view'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at as user_registerion_date,
    updated_at,
    address_id
FROM {{ source('raw', 'users') }}