{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    page_url,
    created_at,
    event_type,
    order_id,
    product_id
FROM {{ source('tutorial', 'events') }}