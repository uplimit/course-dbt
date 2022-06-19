{{
  config(
    materialized='table'
  )
}}

WITH src_greenery__events AS (
  SELECT * FROM {{source('staging_greenery', 'events')}}
)

, renamed_recast AS (
  SELECT
    event_id,
    session_id,
    user_id,
    page_url,
    created_at AS created_at_utc,
    event_type,
    order_id,
    product_id
  FROM src_greenery__events
)

SELECT * FROM renamed_recast
