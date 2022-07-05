SELECT
    events.event_id
    ,events.session_id
    ,events.user_id
    ,events.page_url
    ,events.created_at_utc
    ,events.event_type
    ,events.order_id
    ,events.product_id

FROM {{ ref('stg_events__events') }} AS events