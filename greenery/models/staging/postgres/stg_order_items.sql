{{ config(materialized='table') }}

SELECT
  order_id,
  product_id,
  quantity
FROM {{ source('_postgres__sources', 'order_items')}} order_items