
{{
  config(
    materialized='table'
  )
}}

select
  user_id,
  first_name,
  last_name,
  email,
  phone_number,
  created_at,
  updated_at,
  address_id,
  address,
  zipcode,
  state,
  country
from {{ ref('int_user_address')}} user_address