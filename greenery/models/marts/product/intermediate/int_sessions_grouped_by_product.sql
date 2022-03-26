{{
  config(
    materialized='table'
  )
}}

with stg_events as (
    select * from {{ref('stg_events')}}
)

, stg_order_items as (
        select *
        from {{ref('stg_order_items')}}
)
/*
Checkout events have null values in the product_id column. 

Want to be able to tie session to products purchased to calculate conversion rate. 
*/
, checkout_events_add_products as (
select stg_order_items.product_id, count(distinct(session_id)) as unique_purchase_sessions
from stg_events 
inner join stg_order_items
  on stg_events.order_id = stg_order_items.order_id 
where stg_events.event_type = 'checkout'
group by 1
)

, page_views as (
select 
stg_events.product_id  
, count(distinct( case 
        when stg_events.event_type = 'page_view' 
        then stg_events.session_id ELSE NULL END)) as unique_page_view_sessions 
, count(distinct( case 
        when stg_events.event_type = 'add_to_cart' 
        then stg_events.session_id ELSE NULL END)) as unique_add_to_cart_sessions 
from stg_events 
where product_id is not NULL 
group by product_id)

select page_views.product_id, unique_page_view_sessions , unique_add_to_cart_sessions, unique_purchase_sessions
from page_views 
left join checkout_events_add_products 
on page_views.product_id = checkout_events_add_products.product_id 
