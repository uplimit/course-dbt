{{ 
  config(
    materialized='view'
  ) 
}}

with addresses as (

    select * from {{ source('_postgres__sources', 'addresses') }}

)

select 
  address_id,
  address,
  zipcode,
  state,
  country
 
from addresses