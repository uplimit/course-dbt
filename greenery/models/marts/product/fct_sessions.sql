{{
  config(
    materialized = 'table'
  )
}}
-- Get the time the session started and the time it ended
WITH session_length AS (
    SELECT
      session_id
      , min(created_at_utc) AS first_event
      , max(created_at_utc) AS last_event
    FROM {{ ref('stg_greenery__events') }}
    GROUP BY 1
    
)