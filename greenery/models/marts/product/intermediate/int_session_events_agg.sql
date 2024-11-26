SELECT 
    events.session_id
    , events.created_at_utc
    , events.user_id
    , events.page_url
    , SUM(CASE WHEN event_type = 'package shipped' THEN 1 ELSE 0 END) AS package_shipped
    , SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
    , SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
    , SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
FROM {{ ref('stg_events__events') }} AS events
GROUP BY 1, 2, 3, 4