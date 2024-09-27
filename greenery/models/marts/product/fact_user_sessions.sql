

{{
  config(
    materialized='table'
  )
}} 

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

sessions_int AS (
    SELECT * FROM {{ ref('int_session_events') }}
)

SELECT 
    e.session_id,
    e.user_id,
    MIN(e.created_at) as session_start,
    MAX(e.created_at) as session_end,
    DATEDIFF('minute', MIN(e.created_at), MAX(e.created_at)) as session_length_mins,
    si.checkout_total,
    si.package_shipped_total,
    si.add_to_cart_total,
    si.page_view_total,
    si.has_converted

FROM events e
LEFT JOIN sessions_int si ON e.session_id = si.session_id

GROUP BY 1,2,6,7,8,9,10