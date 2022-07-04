WITH session_length AS (
    SELECT session_id
            , MAX(created_at_utc) AS first_event
            , MIN(created_at_utc) AS last_event
    FROM {{ ref('int_session_events_agg') }} AS events
    GROUP BY session_id
)

SELECT events_agg.session_id
        , events_agg.user_id
        , users.first_name
        , users.last_name
        , users.email
        , events_agg.page_view
        , events_agg.add_to_cart
        , events_agg.checkout
        , events_agg.package_shipped
        , session_length.first_event
        , session_length.last_event
        , (DATE_PART('DAY', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 +
    DATE_PART('HOUR', session_length.last_event::timestamp - session_length.first_event::timestamp)) * 60 +
    DATE_PART('MINUTE', session_length.last_event::timestamp - session_length.first_event::timestamp)
    AS session_length_minutes
FROM {{ ref('int_session_events_agg') }} AS events_agg
LEFT JOIN {{ ref('stg_users__users') }} AS users ON events_agg.user_id = users.user_id
LEFT JOIN session_length ON events_agg.session_id = session_length.session_id