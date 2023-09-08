{{
  config(
    materialized='table'
  )
}}

-- Create list of event types to loop through
{% set event_types = ["checkout", "package_shipped", "add_to_cart", "page_view"] %}

with events_source as (
    select * from {{ ref('stg_postgres_events') }}
),

results as (
    select
        {{ dbt_utils.surrogate_key(['user_id', 'session_id', 'order_id']) }}  as unique_key,
        user_id,
        session_id,
        order_id,
        
        {%- for event_type in event_types -%}
        count(case 
                when event_type = '{{event_type}}' 
                    then event_id 
            end)                                                  as {{event_type}}_count,
        {%- endfor -%}

        count(distinct product_id)                                as product_count,

        min(created_at)                                           as session_start_at,
        max(created_at)                                           as session_end_at,

        datediff('minutes', session_start_at, session_end_at)     as session_length_min

    from events_source
    {{ dbt_utils.group_by(n=4) }}
)

select * from results