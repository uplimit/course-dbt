SELECT events_agg.session_id
        , events_agg.user_id
        , events_agg.page_view
        , events_agg.created_at_utc
        , events_agg.page_url
FROM {{ ref('int_session_events_agg') }} AS events_agg