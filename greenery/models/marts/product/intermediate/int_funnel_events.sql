WITH visits AS (
    SELECT session_id
          , MIN(created_at_utc) AS first_event
    FROM {{ ref('stg_events') }}
    WHERE event_type IN ('page_view'
                        ,'add_to_cart'
                        ,'checkout'
                        )
    GROUP BY session_id
),

activates AS (
    SELECT DISTINCT events.session_id
    FROM visits
    JOIN {{ ref('stg_events') }} events ON visits.session_id = events.session_id
    WHERE events.event_type IN ('add_to_cart'
                                 ,'checkout'
                        )
),

purchases AS (
    SELECT DISTINCT events.session_id
    FROM activates
    JOIN {{ ref ('stg_events') }} events ON activates.session_id = events.session_id
    WHERE event_type = 'checkout'
)

SELECT 'Visits' AS step
        ,COUNT(*)
FROM visits

UNION

SELECT 'Activates' AS step
        ,COUNT(*)
FROM activates

UNION

SELECT 'Purchases' AS step
        ,COUNT(*)
FROM purchases

ORDER BY COUNT DESC