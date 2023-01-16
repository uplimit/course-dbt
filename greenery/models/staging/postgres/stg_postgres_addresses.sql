{{
  config(
    materialized='table'
  )
}}

WITH source_addresses AS (
    SELECT * FROM {{ source( 'postgres', 'addresses' ) }}
)

, renamed_recast AS (
    SELECT address_id AS addresse_guid
           , lower(REPLACE(address,' ','_')) AS address
           , zipcode
           , lower(REPLACE(state,' ','_')) AS state
           , lower(REPLACE(country,' ','_')) AS country
    FROM source_addresses
)

SELECT * FROM renamed_recast