{{ config(materialized='table') }}

select
  user_id,
  first_name,
  last_name,
  email,
  phone_number,
  created_at,
  updated_at,
  address_id 
from {{ source('_postgres__sources', 'users')}} users