{{
  config(
    materialized='table'
  )
}}

with stg_users as (
    
    select * from {{ref('stg_users') }}
    
)

, int_orders as (
    
    select * from {{ref('int_orders_grouped_by_user')}}
)

, int_sessions as (
    select * from {{ref('int_events_grouped_by_user')}}
)

, stg_addresses as (
    
    select * from {{ref('stg_addresses')}}
)

SELECT 
    stg_users.* 
    ,  stg_users.first_name || stg_users.last_name as full_name 
    , stg_addresses.address
    , stg_addresses.zipcode 
    , stg_addresses.state 
    , stg_addresses.country 
    , int_orders.num_of_orders 
    , int_orders.num_of_promos
    , int_orders.first_order_created_at 
    , int_orders.last_order_created_at 
    , int_orders.total_order_cost 
    , int_orders.total_shipping_cost  
    , int_orders.total_order_total
    , int_sessions.num_of_events 
    , int_sessions.num_of_sessions
    , int_sessions.first_event_created_at 
    , int_sessions.last_event_created_at  
    , int_sessions.num_of_page_view_events 
    , int_sessions.num_of_add_to_cart_events 
    , int_sessions.num_of_checkout_events 
    , int_sessions.num_of_package_shipped_events

FROM stg_users 
LEFT JOIN int_orders 
    ON stg_users.user_id = int_orders.user_id 
LEFT JOIN int_sessions 
    ON stg_users.user_id = int_sessions.user_id 
LEFT JOIN stg_addresses 
    ON stg_users.address_id = stg_addresses.address_id
