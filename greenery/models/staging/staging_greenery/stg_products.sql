{{
  config(
    materialized='table'
  )
}}

WITH src_greenery_products AS (
  SELECT * FROM {{source('staging_greenery', 'products')}}
)

, renamed_recast AS (
  SELECT
    product_id,
    name,
    price,
    inventory
  FROM src_greenery_products
)

SELECT * FROM renamed_recast