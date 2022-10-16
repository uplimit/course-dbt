{{
  config(
    materialized='table'
  )
}}

WITH session_events AS (
  SELECT * 
  FROM {{ ref('int_session_events') }}
),

session_duration AS (
    SELECT
    session_id,
    MIN(created_at) AS first_event,
    MAX(created_at) AS last_event

    FROM {{ ref('stg_events') }} 

    GROUP BY 1
),

users AS (
  SELECT *
  FROM {{ ref('stg_users') }} 
)

SELECT
DISTINCT
se.session_id,
se.user_id,
u.first_name,
u.last_name,
u.email,
u.phone_number,
sd.first_event AS first_session_event,
sd.last_event AS last_session_event,
se.page_views,
se.add_to_carts,
se.checkouts,
se.packages_shipped

FROM session_events se 
LEFT JOIN users u 
ON u.user_id = se.user_id
LEFT JOIN session_duration sd
ON sd.session_id = se.session_id
