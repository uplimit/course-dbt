{{ config (materialized='table')}}

SELECT
    session_id,
    user_id,
    min(created_at_utc) as session_first_event,
    max(created_at_utc) as session_last_event,
    sum(case when order_id is not null then 1 else 0 end) AS session_conversion_events,
    sum(case when event_type = 'page_view' then 1 else 0 end) as session_page_views,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as session_adds_to_cart
FROM {{ref('stg_greenery_events')}} e 
GROUP BY 1,2