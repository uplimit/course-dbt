{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    first_name, 
    last_name,
    email,
    phone_number,
    DATE(created_at) as created_at,
    DATE(updated_at) as updated_at,
    address_id
FROM {{ source('postgres', 'users') }}