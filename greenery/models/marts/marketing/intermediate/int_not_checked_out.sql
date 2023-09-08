{{
  config(
    materialized='table'
  )
}}

with stg_events as (
    select * from {{ref('stg_events')}}
)


, page_cart as (
    select *
    from stg_events 
    where event_type IN ('page_view', 'add_to_cart')
)

, checkout as (
    select *
    from stg_events 
    where event_type = 'checkout'
)

--- determine 

select *
from checkout
limit 10