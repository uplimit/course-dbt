{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

with 
session_events_agg as (
select * from {{ref('int_session_events_agg')}}
), 
users as (
    select * from {{ ref('stg_postgres_users')}} )

select 
    session_events_agg.session_id,
    session_events_agg.event_id,
    users.user_first_name,
    users.user_last_name,
    users.user_email,
    session_events_agg.page_views,
    session_events_agg.add_to_carts,
    session_events_agg.checkouts,
    session_events_agg.package_shippeds
    
from session_events_agg
left join users
on session_events_agg.event_id = users.user_id
