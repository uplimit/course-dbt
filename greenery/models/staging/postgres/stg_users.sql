{{ config(materialized='table') }}

SELECT
  user_id,
  first_name,
  last_name,
  email,
  phone_number,
  created_at,
  updated_at,
  address_id 
FROM {{ source('_postgres__sources', 'users')}} users