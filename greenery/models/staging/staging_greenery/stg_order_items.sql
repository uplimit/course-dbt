{{
  config(
    materialized='table'
  )
}}

SELECT
  order_id,
  product_id,
  quantity
FROM {{ source('staging_greenery', 'order_items') }}