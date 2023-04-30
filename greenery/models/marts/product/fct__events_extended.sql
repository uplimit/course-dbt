 {{
  config(
    materialized='table'
  )
}}

WITH events_extended AS (
    SELECT
          stge.event_id
        , stge.session_id
        , stge.user_id
        , stge.page_url_type
        , stge.created_at AS event_timestamp
        , stge.event_type
        , stgpo.order_id AS event_type_order_id
    FROM {{ ref('stg_postgres__events') }} AS stge
    JOIN {{ ref('dim__customers') }} AS dc ON stge.user_id = dc.user_id
    LEFT JOIN {{ ref('stg_postgres__orders') }} AS stgpo ON stge.order_id = stgpo.order_id AND stge.user_id = stgpo.user_id
)

SELECT 
    * 
FROM events_extended