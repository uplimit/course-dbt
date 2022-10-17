{{ config(materialized='table') }}

select
  address_id,
  address,
  zipcode,
  state,
  country
from {{ source('_postgres__sources', 'addresses')}} addresses