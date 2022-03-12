{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id AS address_guid,
    address,
    zipcode,
    state,
    country
FROM {{ source('tutorial', 'addresses') }}