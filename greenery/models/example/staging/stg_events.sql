{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id AS event_guid,
    session_id AS session_guid,
    page_url,
    created_at,
    event_type,
    order_id AS order_guid,
    product_id AS product_guid
FROM {{ source('tutorial', 'events') }}