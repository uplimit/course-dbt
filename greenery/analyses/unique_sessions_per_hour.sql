with events as (

    select
        session_id,
        created_at_utc,
        date_part(hour, created_at_utc) as event_hour
    from
        {{ ref('stg_postgres__events') }}

),

sessions_hours as (

    select
        event_hour,
        count(distinct session_id) as unique_sessions
    from
        events
    group by 1
    order by 1


)

select avg(unique_sessions) from sessions_hours
    