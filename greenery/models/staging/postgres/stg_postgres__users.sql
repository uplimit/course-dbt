{{
  config(
    materialized='view',
    enabled=true
  )
}}

select 
  user_id,
  address_id,
  first_name,
  last_name,
  email,
  phone_number,
  created_at,
  updated_at

from {{ source('postgres', 'users') }}