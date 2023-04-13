{{
  config(
    materialized='view',
    enabled=true
  )
}}

select 
  address_id,
  address,
  country,
  state,
  zipcode

from {{ source('postgres', 'addresses') }}