 {{
  config(
    materialized='table'
  )
}}

WITH promos AS (
    SELECT
          stgpm.promo_id
        , stgpm.discount
        , stgpm.status
    FROM {{ ref('stg_postgres__promos') }} AS stgpm
)

SELECT 
    * 
FROM promos