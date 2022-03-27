{% macro sessions_per_event(column_name, event_type) %}

    select 
        {{column_name}},
        cast(count(distinct session_id) as numeric) as total_sessions
    from {{ ref('stg_events') }}
    where event_type = '{{event_type}}'
    group by 1

{% endmacro %}