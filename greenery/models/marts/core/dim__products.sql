 {{
  config(
    materialized='table'
  )
}}

WITH products AS (
    SELECT
          stgpr.product_id
        , stgpr.name
        , stgpr.price
        , stgpr.inventory
    FROM {{ ref('stg_postgres__products') }} AS stgpr
)

SELECT 
    * 
FROM products