{{
  config(
    materialized='table'
  )
}}

WITH src_greenery_users AS (
  SELECT * FROM {{source('staging_greenery', 'users')}}
)

, renamed_recast AS (
  SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
  FROM src_greenery_users
)

SELECT * FROM renamed_recast

-- SELECT
--   user_id,
--   first_name,
--   last_name,
--   email,
--   phone_number,
--   created_at,
--   updated_at,
--   address_id
-- FROM {{ source('staging_greenery', 'users') }}