{{
  config(
    materialized='table'
  )
}}
    select 
        event_id as page_view_id,
        session_id,
        user_id,
        page_url,
        created_at_utc,
        order_id,
        product_id
FROM {{ ref('fact_events') }}
WHERE event_type = 'page_view'