{{
  config(
    materialized='table'
  )
}}

SELECT 
address_id AS address_id,
address AS address,
zipcode AS zipcode,
state AS state,
country AS country
FROM {{ source('greenery', 'addresses') }}
