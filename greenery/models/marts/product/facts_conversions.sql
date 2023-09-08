{{
  config(
    materialized='view'
  )
}}

with sessions as (
    select * from {{ref('int_events_grouped_by_sessions')}}
)


, sum_sessions as (

  select 
   sum(page_view_session) as sum_page_view_session 
  , sum(add_to_cart_session) as sum_add_to_cart_session
  , sum(purchase_session) as sum_purchase_session
  from sessions 
)

-- calculate funnel conversion rates 

select 
  -- # of unique sessions with add to cart event / # of unique sessions with a page view 
   {{calculate_rates('sum_add_to_cart_session', 'sum_page_view_session')}}  as view_cart_conversion_rate 

 --  # of unique sessions with purchase event / # of unique sessions with add to cart  
  ,  {{calculate_rates('sum_purchase_session', 'sum_add_to_cart_session')}} as cart_purchase_conversion_rate 

  -- # of unique sessions with purchase event / # of unique sessions with a page view 
  ,  {{calculate_rates('sum_purchase_session', 'sum_page_view_session')}} as view_purchase_conversion_rate 
from sum_sessions
