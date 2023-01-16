{{
  config(
    materialized='table'
  )
}}

WITH source_products AS (
    SELECT * FROM {{ source( 'postgres', 'products' ) }}
)

, renamed_recast AS (
    SELECT product_id AS product_guid
           , lower(REPLACE(name,' ','_')) AS name
           , price
           , inventory
    FROM source_products
)

SELECT * FROM renamed_recast