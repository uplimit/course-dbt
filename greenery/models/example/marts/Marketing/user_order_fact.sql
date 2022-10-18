{{ config(materialized='table') }}

with user_most_recent_orders as (
    select
        user_guid,
        ship_address,
        ship_state,
        ship_zipcode,
        ship_country,
        created_at_tstamp_est as last_order_tstamp_est
    from {{ref('fact_orders')}} fo
    where user_most_recent_order_flag = TRUE
)

,user_info as (
    select
    *
    from {{ref('dim_users')}}
    
)

,user_order_history as (
    select
        user_guid,
        count(distinct order_guid) as order_count,
        count(distinct case when delivered_at_tstamp_est is not null then order_guid end) as delivered_order_count
        from {{ref('fact_orders')}}
    group by 1 
)

,combined as (
    select
        ui.user_guid,
        ui.full_name,
        ui.email,
        ui.phone_number,
        ui.first_order_created_tstamp_est,
        ui.first_order_delivered_tstamp_est,
        uo.ship_address as last_ship_address,
        uo.ship_state as last_ship_state,
        uo.ship_zipcode as last_ship_zipcode,
        uo.ship_country as last_ship_country,
        uo.last_order_tstamp_est,
        coalesce(oh.order_count,0) as order_count,
        coalesce(oh.delivered_order_count,0) as delivered_order_count
    from user_info ui
    left join user_order_history oh
    on ui.user_guid = oh.user_guid
    left join user_most_recent_orders uo
    on ui.user_guid = uo.user_guid
)

SELECT
*
from combined