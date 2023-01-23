with events as (

    select
        *
    from
        {{ ref('stg_postgres__events') }}

),

session_agg as (

    select
        session_id,
        user_id,
        min(created_at_utc) as first_session_event,
        max(created_at_utc) as last_session_event,
        datediff(minute, first_session_event, last_session_event) as session_length_mins,
        count(event_id) as events_in_session
    from
        events
    group by 1,2

),

session_seq as (

    select
        session_id,
        event_type,
        created_at_utc
    from
        events
),

final as (

    select
        session_agg.session_id,
        session_agg.user_id,
        session_agg.first_session_event,
        session_agg.last_session_event,
        session_agg.session_length_mins,
        session_agg.events_in_session,
        session_seq.event_type as last_event_in_session,
        case
            when last_event_in_session = 'package_shipped' then 'order_shipped'
            when last_event_in_session = 'checkout' then 'order_placed'
            when last_event_in_session = 'add_to_cart' then 'cart_abandoned'
            when last_event_in_session = 'page_view' then 'browsing'
        end as session_result
    from
        session_agg
    inner join
        session_seq 
        on session_agg.session_id = session_seq.session_id 
        and session_agg.last_session_event = session_seq.created_at_utc

)

select * from final
