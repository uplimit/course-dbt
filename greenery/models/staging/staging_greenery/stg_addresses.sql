{{
  config(
    materialized= 'view'
  )
}}

with src_greenery_addresses as (
  select * from {{ source('staging_greenery', 'addresses') }}
)

, renamed_recast as (
  select
    address_id,
    address,
    zipcode,
    state,
    country
  from src_greenery_addresses
)

SELECT * FROM renamed_recast
-- SELECT
--   address_id,
--   address,
--   zipcode,
--   state,
--   country
-- FROM {{ source('staging_greenery', 'addresses') }}
