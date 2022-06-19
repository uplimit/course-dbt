{{
  config(
    materialized = 'table'
  )
}}

SELECT
  session_id
  , user_id
  , created_at_utc
  , SUM(CASE WHEN event_type = 'add_to_cart' then 1 else 0 end) AS add_to_cart
  , SUM(CASE WHEN event_type = 'checkout' then 1 else 0 end) AS checkout
  , SUM(CASE WHEN event_type = 'page_view' then 1 else 0 end) AS page_view
  , SUM(CASE WHEN event_type = 'package_shipped' then 1 else 0 end) AS package_shipped
FROM {{ ref('stg_greenery__events') }}
GROUP BY 1,2,3