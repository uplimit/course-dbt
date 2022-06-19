{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__products AS (
  SELECT * FROM {{source('staging_greenery', 'products')}}
)

, renamed_recast AS (
  SELECT
    product_id,
    name AS product_name,
    price,
    inventory
  FROM src_greenery__products
)

SELECT * FROM renamed_recast