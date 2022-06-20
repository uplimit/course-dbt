{{
  config(
    materialized = 'table'
  )
}}

WITH fact_page_views AS(
    SELECT 
        * 
    FROM 
    {{ 
        ref('int_session_events_aggregate')
    }}
)
SELECT 
    * 
FROM 
    fact_page_views 