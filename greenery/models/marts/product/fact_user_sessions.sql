{{
  config(
    materialized='table'
  )
}}

WITH session_events AS (
  SELECT * 
  FROM {{ ref('int_session_events') }}
),

user_session_count AS (
    SELECT
    user_id,
    count(DISTINCT session_id) as total_session_count

    FROM {{ ref('stg_events') }} 

    GROUP BY 1
),

users AS (
  SELECT *
  FROM {{ ref('stg_users') }} 
)

SELECT
se.user_id,
u.first_name,
u.last_name,
u.email,
u.phone_number,
se.page_view_total,
se.add_to_cart_total,
se.checkout_total,
se.package_shipped_total,
usc.total_session_count


FROM session_events se 
LEFT JOIN users u 
ON u.user_id = se.user_id
LEFT JOIN user_session_count usc
ON usc.user_id = u.user_id

