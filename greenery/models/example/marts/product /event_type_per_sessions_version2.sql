{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery_events'),
    column='event_type'
) -%}

select
session_id,
{%- for event_type in event_types %}
sum(case when event_type = '{{event_type}}' then 1 end) as {{event_type}}_count
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('stg_greenery_events') }}
group by 1
