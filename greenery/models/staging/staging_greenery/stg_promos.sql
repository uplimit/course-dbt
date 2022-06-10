{{
  config(
    materialized='table'
  )
}}

WITH src_greenery_promos AS (
  SELECT * FROM {{source('staging_greenery', 'promos')}}
)

, renamed_recast AS (
  SELECT
    promo_id,
    discount,
    status
  FROM src_greenery_promos
)

SELECT * FROM renamed_recast

-- SELECT
--   promo_id,
--   discount,
--   status
-- FROM {{ source('staging_greenery', 'promos') }}