{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id,
    address,
    zipcode,
    state,
    country
FROM {{ source('tutorial', 'addresses')}}