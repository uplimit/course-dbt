{{ config (materialized='table')}}

SELECT
    session_id,
    u.user_id,
    u.first_name,
    u.last_name,
    session_first_event,
    session_last_event,
    session_last_event - session_first_event as session_length,
    case when session_conversion_events > 0 then TRUE else FALSE end as session_converted
FROM {{ref('int_session_events')}} s
LEFT JOIN {{ref('stg_greenery_users')}} u on u.user_id = s.user_id