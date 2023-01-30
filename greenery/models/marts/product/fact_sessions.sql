with events as (

    select
        *
    from
        {{ ref('stg_postgres__events') }}

),

final as (

    select
        session_id,
        user_id,
        min(created_at_utc) as first_session_event,
        max(created_at_utc) as last_session_event,
        {{ get_event_type_counts() }},
        datediff(minute, first_session_event, last_session_event) as session_length_mins,
        count(event_id) as events_in_session
    from
        events
    group by 1,2

)

select * from final
