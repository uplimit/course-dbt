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
-- Add in _________ information
-- Calculate the session length
select
    int_session_events_agg.session_id
    , int_session_events_agg.user_id
    , stg_greenery__users.first_name
    , stg_greenery__users.last_name
    , stg_greenery__users.email

    , int_session_events_agg.page_view
    , int_session_events_agg.add_to_cart
    , int_session_events_agg.checkout
    , int_session_events_agg.package_shipped  
    , session_length.first_event as first_session_event
    , session_length.last_event as last_session_event
    , (date_part...)
    as session_length_minutes
    