{{
  config(
    materialized = 'table'
  )
}}

WITH int_product_checkout_purchases AS (
SELECT  order_items.product_guid
        , COUNT(DISTINCT events.session_guid) AS sessions_with_product_checkout
 FROM 
    {{ ref('stg_greenery__events') }} AS events
 LEFT JOIN {{ ref('stg_greenery__order_items') }} AS order_items 
 ON events.order_guid = order_items.order_guid
 WHERE 
        events.event_type = 'checkout'
 GROUP BY 
        order_items.product_guid
)
SELECT 
    * 
FROM 
    int_product_checkout_purchases

