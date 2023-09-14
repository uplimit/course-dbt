{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    DATE(created_at) as created_at,
    shipping_cost,
    order_id,
    product_id
FROM {{ source('postgres', 'events') }}