{{
  config(
    materialized='table'
  )
}}

{% set event_types = dbt_utils.get_column_values(
  table=ref('stg_postgres__events'), 
  column='event_type') 
%}


with session_timing as (
  select * from {{ ref('int_session_timing') }}
)

select 
    e.session_id,
    e.user_id,
    coalesce(e.product_id, oi.product_id) as product_id,
    session_started_at,
    session_ended_at,
    {% for event_type in event_types %}
    {{ sum_of('e.event_type', event_type )}} as {{ event_type }}s,
    {% endfor %}
    datediff('minute', session_started_at, session_ended_at) as session_length
    from {{ ref('stg_postgres__events') }} e
left join {{ ref('stg_postgres__order_items') }} oi using (order_id)
left join session_timing using (session_id)
group by 1,2,3,4,5 
