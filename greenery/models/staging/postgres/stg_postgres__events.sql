{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id::VARCHAR(256) as event_id,
    session_id::VARCHAR(256) as session_id,
    user_id::VARCHAR(256) as user_id,
    page_url::VARCHAR(4096) as page_url,
    created_at::TIMESTAMP as created_at,
    event_type::VARCHAR(128) as event_type,
    order_id::VARCHAR(256) as order_id,
    product_id::VARCHAR(256) as product_id
FROM {{ source('postgres', 'events') }}