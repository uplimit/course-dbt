
{{
  config(
    materialized='table'
  )
}}

with sessions as (
select 
    sum(page_view + add_to_cart + checkout) as total_sessions,
    sum(page_view) page_view,
    sum(add_to_cart) add_to_cart,
    sum(checkout) checkout
from  {{ ref('int_user_events')}})
select 
    page_view/total_sessions*100 as page_view_rate,
    add_to_cart/total_sessions*100 as add_to_cart_rate,
    checkout/total_sessions*100 as checkout_rate
from sessions