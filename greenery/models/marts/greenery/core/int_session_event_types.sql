-- model: int_session_event_types.sql
{{ 
    config( materialized='table' ) 
}}

{% set event_types = 
    dbt_utils.get_query_results_as_dict("select distinct event_type from" ~ ref('greenery','stg_greenery__events'))  %}

-- int_session_event_types.sql
SELECT 
    et.session_id
    {% for event_type in event_types['event_type'] %}
       , MAX(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present
    {%  endfor %}
FROM {{ ref('greenery', 'stg_greenery__events') }} et
GROUP BY e.session_id