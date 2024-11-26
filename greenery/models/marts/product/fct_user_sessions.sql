{{
    config(
        MATERIALIZED = 'table'
    )
}}

with session_length as (
    select 
    session_id, 
    min (created_at::timestamp_ntz as event_created_at_utc) as first_event,
    max (created_at::timestamp_ntz as event_created_at_utc) as last_event
    from {{ref ('stg_postgres_events')}}
    group by 1 
    )
, session_events_agg as (
    select * from {{ ref('int_session_events_agg')}}
)
, users as (
    select * from {{'stg_postgres_users'}}
)

select
    session_events_agg.session_id,
    session_events_agg.event_id,
    users.user_first_name,
    users.user_last_name,
    users.user_email,
    session_events_agg.page_views,
    session_events_agg.add_to_carts,
    session_events_agg.checkouts,
    session_events_agg.package_shippeds,
    session_length.first_event as first_session_event,
    session_length.last_event as last_session_event,
    datediff ('minute', session_length.first_event, session_length.last_event) as session_length_minutes

from session_events_agg
left join users
on session_events_agg.event_id = users.user_id
left join session_length
on session_events_agg.event_id = session_length.session_id    