{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__promos AS (
  SELECT * FROM {{source('staging_greenery', 'promos')}}
)

, renamed_recast AS (
  SELECT
    promo_id,
    discount AS discount_amount,
    status AS promo_active_status
  FROM src_greenery__promos
)

SELECT * FROM renamed_recast