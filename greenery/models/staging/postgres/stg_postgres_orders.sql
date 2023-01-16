{{
  config(
    materialized='table'
  )
}}

WITH source_orders AS (
    SELECT * FROM {{ source( 'postgres', 'orders' ) }}
)

, renamed_recast AS (
    SELECT order_id AS order_guid
           , user_id AS user_guid
           , lower(REPLACE(promo_id,' ','_')) AS promo_description
           , address_id AS address_guid
           , created_at::timestamp AS created_at_utc
           , order_cost
           , shipping_cost
           , order_total
           , tracking_id AS tracking_guid
           , lower(REPLACE(shipping_service,' ','_')) AS shipping_service
           , estimated_delivery_at::timestamp AS estimated_delivery_at_utc
           , delivered_at::timestamp AS delivered_at_utc
           , lower(REPLACE(status,' ','_')) AS status
    FROM source_orders
)

SELECT * FROM renamed_recast