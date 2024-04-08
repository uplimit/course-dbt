with
events as ( select * from {{ref('stg_postgres__events')}}),
order_items as ( select * from {{ref('stg_postgres__order_items')}}),
session_agg as ( select * from {{ref('int_session_dates')}})

{% set event_types = dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type')  %}

select 
    e.session_id,
    e.user_id,
    coalesce(e.product_id, o.product_id) as product_id,
    session_start_date,
    session_end_date,
    {% for event_type in  event_types%}
    {{sum_of_events('e.event_type', 'event_type')}} as {{event_type}}s,
    {% endfor %}
from events e
left join order_items o on e.order_id = o.order_id
left join session_agg s on s.session_id = e.session_id
group by 1,2,3,4,5