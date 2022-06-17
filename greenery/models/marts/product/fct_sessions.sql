{{
    config(
        materialized = 'table'
    )
}}

with session_length as (
    SELECT
        session_guid
        , min(event_created_at_utc) as first_event
        , max(event_created_at_utc) as last_event
    from {{ ref('stg_greenery__events') }}
    GROUP BY 1
)

SELECT
    int_sessions_events_agg.session_guid
    , int_sessions_events_agg.user_guid
    , stg_greenery__users.first_name
    , stg_greenery__users.last_name
    , stg_greenery__users.email
    , int_sessions_events_agg.event_created_at_utc
    , int_sessions_events_agg.package_shipped
    , int_sessions_events_agg.page_view
    , int_sessions_events_agg.checkout
    , int_sessions_events_agg.add_to_cart
    , session_length.first_event as first_session_event
    , session_length.last_event as last_session_event
    , session_length.first_event - session_length.first_event as session_length
from {{ ref('int_sessions_events_agg') }}

left join  {{ ref('stg_greenery__users') }}
    on int_sessions_events_agg.user_guid = stg_greenery__users.user_guid
left join session_length
    on int_sessions_events_agg.session_guid = session_length.session_guid