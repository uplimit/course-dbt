{{
  config(
    materialized='table'
  )
}}

WITH source_order_items AS (
    SELECT * FROM {{ source( 'postgres', 'order_items' ) }}
)

, renamed_recast AS (
    SELECT order_id AS order_guid
           , product_id AS product_guid
           , quantity
    FROM source_order_items
)

SELECT * FROM renamed_recast