
{{
  config(
    materialized='table'
  )
}}

{%- set event_types = get_event_types() -%}

select
  e.user_id,
  count(distinct e.session_id) num_sessions,
  min(e.created_at) first_session_date,
  max(e.created_at) last_session_date,
  datediff(hour, first_session_date, last_session_date) total_session_duration,
  count(e.order_id) total_orders,
  count(e.product_id) total_products
  {%- for event_type in event_types %}
    ,sum(case when event_type = '{{event_type}}' then 1 else 0 end) {{event_type}}
    {%- endfor %}
from {{ ref('stg_events')}} e
group by 1