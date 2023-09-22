{{
  config(
    materialized='table'
  )
}}

SELECT
created_at as date,
product_id, 
product_name,
COUNT(DISTINCT CASE WHEN event_type='page_view' THEN event_id ELSE null END) as page_views,
COUNT(DISTINCT session_id) as sessions

FROM {{ ref('int_product_events') }} 

GROUP BY 1,2,3