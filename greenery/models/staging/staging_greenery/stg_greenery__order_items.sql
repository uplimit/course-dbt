{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__order_items AS (
  SELECT * FROM {{source('staging_greenery', 'order_items')}}
)

, renamed_recast AS (
  SELECT
  order_id,
  product_id,
  quantity
  FROM src_greenery__order_items
)

SELECT * FROM renamed_recast