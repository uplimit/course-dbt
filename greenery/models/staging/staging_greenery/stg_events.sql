{{
  config(
    materialized='table'
  )
}}

WITH src_greenery_events AS (
  SELECT * FROM {{source('staging_greenery', 'events')}}
)

, renamed_recast AS (
  SELECT
    event_id,
    session_id,
    user_id,
    page_url,
    created_at,
    event_type,
    order_id,
    product_id
  FROM src_greenery_events
)

SELECT * FROM renamed_recast
