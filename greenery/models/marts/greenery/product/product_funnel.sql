{{ 
    config(
        materialized = 'table'
    )  
}}

WITH product_funnel AS (
-- Product Funnel 
SELECT 
  count(distinct(session_guid)) AS total_sessions 
  , count( distinct case when page_view > 0 then session_guid end) AS page_views
  , count( distinct case when add_to_cart > 0 then session_guid end) AS add_to_carts 
  , count( distinct case when checkout > 0 then session_guid end) AS checkouts
FROM 
    {{ ref('fact_page_views') }}
)
SELECT 
  total_sessions
  , add_to_carts::numeric / page_views::numeric  AS land_and_add_funnel
  , checkouts::numeric / add_to_carts::numeric AS add_and_purchase_funnel
FROM 
  product_funnel
