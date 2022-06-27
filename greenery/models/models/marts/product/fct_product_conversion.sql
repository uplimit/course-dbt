
{%- set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery_events'),
    column='event_type'
) -%}

SELECT
    p.product_id
    {%- for event in event_types %}
  , {{events(event)}} AS {{event}}_counts
  {%- endfor %} 

from {{ref('stg_greenery_products')}} p
left join {{ref('stg_greenery_events')}} e on e.product_id = p.product_id
group by 1