{{ config(
    materialized = "table"
) }}

WITH cte_event_type_count AS (
    SELECT *
    FROM (SELECT session_id, event_id, event_type FROM {{ ref ('stg_event') }})
        PIVOT (
            COUNT (event_id)
            FOR event_type IN (
                -- validated upstream
                'checkout', 'package_shipped', 'add_to_cart', 'page_view'
            )
        ) AS pvt_event_type_count (
            session_id
            , checkout_count
            , package_shipped_event_count
            , add_to_cart_count
            , page_view_count
        )
)

, cte_session_aggregation AS (
    SELECT session_id
        , user_id
        , MIN(event_created_at) session_start_tstamp
        , MAX(event_created_at) session_end_tstamp
        , TIMEDIFF(MINUTE, session_start_tstamp, session_end_tstamp)
            AS session_length_minutes
        , COUNT(DISTINCT page_url) session_url_count
    FROM {{ ref ('stg_event') }}
    GROUP BY 1,2
)

SELECT sa.*
    , etc.page_view_count
    , etc.add_to_cart_count
    , etc.checkout_count
    , etc.package_shipped_event_count
FROM cte_session_aggregation sa
JOIN cte_event_type_count etc
    ON sa.session_id = etc.session_id