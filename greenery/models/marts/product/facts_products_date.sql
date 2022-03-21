{{
  config(
    materialized='table'
  )
}}


with int_events as (
    select * from {{ref('int_events_grouped_by_product_date')}}
)

, int_orders as (
    select * from {{ref('int_orders_grouped_by_product_date')}}
)

select 
int_orders.product_id 
, int_orders.created_at_date
, int_orders.product_name 
, int_orders.num_of_orders 
, int_orders.num_of_items 
, int_orders.total_rev_no_discount 
, int_events.num_of_events 
, int_events.num_of_sessions 
, int_events.num_of_page_view_events 
, int_events.num_of_add_to_cart_events 
, int_events.num_of_checkout_events 
, int_events.num_of_package_shipped_events
from int_events 
left join int_orders 
    on int_events.product_id = int_orders.product_id 
         and int_events.created_at_date = int_orders.created_at_date