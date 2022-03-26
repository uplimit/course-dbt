{{
  config(
    materialized='view'
  )
}}

with sessions as (
    select * from {{ref('int_events_grouped_by_sessions')}}
)

-- calculate funnel conversion rates 

select 
    -- # of unique sessions with add to cart event / # of unique sessions with a page view 
   round(
          (sum(add_to_cart_session)::numeric / sum(page_view_session))::numeric * 100, 2
          ) as view_cart_conversion_rate 

 --  # of unique sessions with purchase event / # of unique sessions with add to cart  
  , round(
        (sum(purchase_session)::numeric / sum(add_to_cart_session))::numeric * 100, 2
        ) as cart_purchase_conversion_rate 

  -- # of unique sessions with purchase event / # of unique sessions with a page view 
    , round(
        (sum(purchase_session)::numeric / sum(page_view_session))::numeric * 100, 2
        ) as view_purchase_conversion_rate 
from sessions
