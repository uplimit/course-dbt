{{ config(materialized='table') }}

SELECT
  product_id,
  name,
  price,
  inventory 
FROM {{ source('_postgres__sources', 'products')}} products