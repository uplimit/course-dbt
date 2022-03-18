WITH session_length AS (
    SELECT 
        session_id
        ,MIN(created_at_utc) AS first_event_time
        ,MAX(created_at_utc) AS last_event_time
    FROM {{ ref('fct_events') }}
    GROUP BY session_id
)

SELECT
    int_agg.session_id
    ,int_agg.user_id
    ,dim_users.user_name
    ,dim_users.email
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
LEFT JOIN {{ ref('dim_users') }} ON int_agg.user_id = dim_users.user_id
LEFT JOIN session_length ON int_agg.session_id = session_length.session_id
