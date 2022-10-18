{{ config(materialized='table') }}

with website_events as (
    SELECT
    *
    from {{ref('src_events')}}
    where lower(event_type) = 'page_view'
)

,products as (
    SELECT
    *
    from {{ref('dim_products')}}
)

,users as (
    SELECT
    *
    from {{ref('dim_users')}}
)

,combined as (
    select 
    --about event
        e.event_guid
        ,e.session_guid
        ,e.created_at_tstamp_est as event_tstamp_est
        ,e.page_url

    --about user
        ,e.user_guid
        ,u.first_order_created_tstamp_est as user_first_order_tstamp_est
        ,u.email as user_email
    --about order   
        ,order_guid

    --about product
        ,e.product_guid
        ,p.product_name
    from website_events e
    left join  products p
    on e.product_guid = p.product_guid
    left join users u
    on e.user_guid = u.user_guid
)

SELECT
*
from combined