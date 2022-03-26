SELECT 
     event_id
    ,session_id
    ,user_id
    ,order_id
    ,product_id
    ,event_type
    ,page_url
    ,created_at_utc
FROM {{ ref('stg_events')}}
