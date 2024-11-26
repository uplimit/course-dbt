{{
  config(
    materialized='table'
  )
}}

with stg_events as (
    
    select * from {{ref('stg_events') }}
    
)

, events_agg as (
SELECT 
    user_id
    , count(event_id) as num_of_events 
    , count(session_id) as num_of_sessions
    , min(created_at) as first_event_created_at 
    , max(created_at) as last_event_created_at  
    , count(case 
            when event_type = 'page_view' 
            then event_id ELSE NULL END) as num_of_page_view_events 
     , count(case 
            when event_type = 'add_to_cart' 
            then event_id ELSE NULL END) as num_of_add_to_cart_events 
     , count(case 
            when event_type = 'checkout' 
            then event_id ELSE NULL END) as num_of_checkout_events 
    , count(case 
            when event_type = 'package_shipped' 
            then event_id ELSE NULL END) as num_of_package_shipped_events

FROM stg_events 
GROUP BY user_id ) 

SELECT *  
FROM events_agg  