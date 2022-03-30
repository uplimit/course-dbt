{{ config(
    tags=['PII']
)
}}

WITH session_length AS (
    SELECT 
        session_id
        ,MIN(created_at_utc) AS first_event_time
        ,MAX(created_at_utc) AS last_event_time
    FROM {{ ref('stg_events') }}
    GROUP BY session_id
)

SELECT
    int_agg.session_id
    ,int_agg.user_id
    ,users.user_name
    ,users.email
    ,int_agg.page_view
    ,int_agg.add_to_cart
    ,int_agg.checkout
    ,int_agg.package_shipped
    ,session_length.first_event_time
    ,session_length.last_event_time
    ,(DATE_PART('DAY', session_length.last_event_time::timestamp - session_length.first_event_time::timestamp) * 24 +
    DATE_PART('HOUR', session_length.last_event_time::timestamp - session_length.first_event_time::timestamp)) * 60 +
    DATE_PART('MINUTE', session_length.last_event_time::timestamp - session_length.first_event_time::timestamp)
    AS session_length_minutes

FROM {{ ref('int_session_events_agg') }} int_agg
LEFT JOIN {{ ref('int_user_address') }} users ON int_agg.user_id = users.user_id
LEFT JOIN session_length ON int_agg.session_id = session_length.session_id
