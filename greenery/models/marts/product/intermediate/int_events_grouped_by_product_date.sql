{{
  config(
    materialized='table'
  )
}}

with stg_events as (
    select * from {{ref('stg_events')}}
)


select 
product_id 
, created_at::date as created_at_date  
, count(distinct event_id) as num_of_events 
, count(distinct session_id) as num_of_sessions 
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
from stg_events 
group by product_id, created_at_date  
order by product_id asc, created_at_date asc 