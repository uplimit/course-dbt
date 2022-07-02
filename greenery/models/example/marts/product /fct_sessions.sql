{{
    config(
        MATERIALIZED='table'
    )
}}

with session_lenght as (

    select 
    session_id
    ,min(created_at ) as first_event
    ,max(created_at) as last_event
    from {{ref('stg_greenery_events')}}
group by 1


)

select 
init_session_events_basic_agg.session_id
,init_session_events_basic_agg.user_id
,stg_greenery_users.first_name
,stg_greenery_users.last_name
,stg_greenery_users.email
,init_session_events_basic_agg.add_to_cart
,init_session_events_basic_agg.checkout
,init_session_events_basic_agg.package_shipped
,session_lenght.first_event as first_session_event
,session_lenght.last_event as last_session_event 


from {{ref('init_session_events_basic_agg')}}
left join {{ref('stg_greenery_users')}}
on init_session_events_basic_agg.user_id="stg_greenery_users".user_id
left join session_lenght
on init_session_events_basic_agg.session_id=session_lenght.session_id
