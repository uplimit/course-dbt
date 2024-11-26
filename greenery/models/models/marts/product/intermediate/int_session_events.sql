{{ config (materialized='table')}}

{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery_events'),
    column='event_type'
) -%}

SELECT
    session_id,
    user_id,
    min(created_at_utc) as session_first_event,
    max(created_at_utc) as session_last_event,
    sum(case when order_id is not null then 1 else 0 end) AS session_conversion_events
    {%- for event in event_types %}
  , {{events(event)}} AS {{event}}_counts
  {%- endfor %} 
    
FROM {{ref('stg_greenery_events')}} e 
GROUP BY 1,2