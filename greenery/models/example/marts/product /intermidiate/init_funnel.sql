{{
    config(
        materialized = 'table'
    )
}}




SELECT 
session_id
,sum(DISTINCT(CASE WHEN checkout_count>0 THEN 1 END)) as checkout_sum
,sum(DISTINCT(CASE WHEN add_to_cart_count>0 THEN 1 END)) as add_to_cart_sum
,sum(DISTINCT(CASE WHEN  page_view_count>0  THEN 1 END)) as page_view_sum
FROM dbt_sofia.event_type_per_sessions
GROUP BY session_id


