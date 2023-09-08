{{
  config(
    materialized='view'
  )
}}

SELECT 
    session_id
    , user_id
    , page_url
    , created_at
    , event_type
    , order_id
    , product_id
FROM {{ source('database', 'events') }}