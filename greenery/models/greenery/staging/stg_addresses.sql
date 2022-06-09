{{
  config(
    materialized='view'
  )
}}



SELECT 
    address_id,
    address,
    zipcode,
    state, -- Is this an optional field, and/or is this field available outside USA?
    country
FROM {{ source('src_greenery', 'addresses')}}