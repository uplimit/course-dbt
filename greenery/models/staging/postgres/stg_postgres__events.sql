{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id::VARCHAR(256),
    session_id::VARCHAR(256),
    user_id::VARCHAR(256),
    page_url::VARCHAR(4096),
    created_at::TIMESTAMP,
    event_type::VARCHAR(128),
    order_id::VARCHAR(256),
    product_id::VARCHAR(256)
FROM {{ source('postgres', 'events') }}