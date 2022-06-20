{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__users AS (
  SELECT * FROM {{source('src_greenery', 'users')}}
)

, renamed_recast AS (
  SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at AS created_at_utc,
    updated_at AS updated_at_utc,
    address_id
  FROM src_greenery__users
)

SELECT * FROM renamed_recast