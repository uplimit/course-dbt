{{
  config(
    materialized = 'table'
  )
}}

WITH int_product_page_views AS (
SELECT  events.product_guid
        , products.name as product_name
        , COUNT(DISTINCT events.session_guid) as sessions_with_product_page_view
 FROM {{ ref('stg_greenery__events') }} AS events
 LEFT JOIN {{ ref('stg_greenery__products') }} AS products 
 ON events.product_guid = products.product_guid
 WHERE events.event_type = 'page_view'
 GROUP BY 
    events.product_guid
    , product_name
)
SELECT 
    * 
FROM 
    int_product_page_views

