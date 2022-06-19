

WITH session_events_aggregate AS (
  SELECT
      session_guid
      , user_guid
      , MIN(created_at_utc) AS session_start
      , MAX(created_at_utc) AS session_end
      , COUNT(event_guid) AS events_per_session
      , COUNT(DISTINCT order_guid) AS orders_placed
      , COUNT(DISTINCT product_guid) AS products_purchased
      , SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped
      , SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
      , SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
      , SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
  FROM 
    {{ 
        ref('stg_greenery__events')
    }}
  GROUP BY 
    session_guid
    , user_guid
)

SELECT  
    * 
FROM 
    session_events_aggregate