{%- set event_types = get_column_values(
    column_name='event_type',
    relation=ref('stg_greenery_events'),
   
) -%}

select
 session_id,
 created_at,
{%- for event_type in event_types %}
sum(case when event_type = '{{event_type}}' then 1 end) as {{event_type}}_count
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('stg_greenery_events') }}
group by 1,2
